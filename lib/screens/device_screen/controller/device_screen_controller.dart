import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' hide Logger;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/device_screen/model/device_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';

import '../../../utils/app_all_log/error_log.dart';
import '../../add_Device_scanner/controller/add_device_controller.dart';
import '../../add_Device_scanner/device_distance_tracking_screen.dart';
import '../../home_screen/model/category_list_model.dart';

class DeviceScreenController extends GetxController {
  RxBool isLoading = false.obs; // Track loading state
  RxBool isPaginationLoading = false.obs; // Track loading state for pagination
  RxInt selectedItem = 1.obs; // For item selection, as before
  List<Devices> devices = []; // List of devices

  int currentPage = 1;
  int totalPage = 1;
  bool isSubscribe=true;

  ScrollController scrollController = ScrollController();



  StreamSubscription<DiscoveredDevice>? _bleScanSubscription;
  final RxMap<String, DiscoveredDevice> _discoveredDevices = <String, DiscoveredDevice>{}.obs;
  Rx<DiscoveredDevice?> connectedBleDevice = Rx<DiscoveredDevice?>(null);
  RxInt currentRssi = 0.obs;
  RxDouble estimatedDistance = 0.0.obs;
  RxBool isBluetoothScanning = false.obs;
  RxBool isBluetoothConnected = false.obs;
  RxString connectionStatus = 'Disconnected'.obs;
  Timer? _rssiUpdateTimer;
  String? scannedDeviceId;



  StreamSubscription<ConnectionStateUpdate>? _bleConnectionSubscription;
  // Existing fields





  // Connection method selector

  // Debug mode: Show ALL Bluetooth devices (not just Minew)
  RxBool showAllDevices = false.obs;
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  @override
  Future<void> onInit() async {
    super.onInit();
    getDevices(); // Load initial devices
    scrollController.addListener(_scrollListener);
    Get.lazyPut(()=>SaveDataController());
    // isSubscribe =await Get.find<SaveDataController>().getIsSubscribe();
    isSubscribe =true;

    Logger().e("===============================$isSubscribe");
  }
  Future<void> onRefresh()async{
    devices.clear();
    update();
    getDevices();
  }

  Future<void> disconnectBluetoothDevice() async {
    try {
      debugPrint('🔌 Disconnecting from beacon device');
      _bleConnectionSubscription?.cancel();
      _bleScanSubscription?.cancel();
      _rssiUpdateTimer?.cancel();
      connectedBleDevice.value = null;
      isBluetoothConnected.value = false;
      connectionStatus.value = 'Disconnected';
      scannedDeviceId = null;
      currentRssi.value = 0;
      estimatedDistance.value = 0.0;
      update();

      showCustomSnackBar(
        title: "Disconnected",
        message: "Device disconnected successfully",
      );
    } catch (e) {
      errorLog("disconnectBluetoothDevice", e);
    }
  }
  Future<void> connectToBluetoothDevice(String deviceId, String name) async {
    try {
      debugPrint('🔗 Connecting to beacon device: $deviceId');

      // For beacon devices (Minew E8, D15N), we don't establish a traditional BLE connection
      // Instead, we continuously monitor their advertisement packets

      final device = _discoveredDevices[deviceId];
      if (device == null) {
        showCustomSnackBar(
          title: "Error",
          message: "Device not found",
        );
        return;
      }

      connectedBleDevice.value = device;
      isBluetoothConnected.value = true;
      connectionStatus.value = 'Connected';
      scannedDeviceId = deviceId;

      // Stop the general scan
      stopBluetoothScan();

      showCustomSnackBar(
        title: "Success",
        message: "Connected to $name",
      );

      debugPrint('✅ Device connected, transferring to tracking screen');

      // Initialize AddDeviceController and transfer connection state
      final addDeviceController = Get.put(AddDeviceController());

      // Transfer device to AddDeviceController's discovered devices map
      addDeviceController.transferDeviceFromExternalController(deviceId, device);

      // Transfer connection state
      addDeviceController.connectedBleDevice.value = connectedBleDevice.value;
      addDeviceController.isBluetoothConnected.value = true;
      addDeviceController.connectionStatus.value = 'Connected';
      addDeviceController.scannedDeviceId = deviceId;

      // Start monitoring in AddDeviceController
      addDeviceController.startMonitoringFromExternalController(deviceId);

      // Stop monitoring in this controller to avoid conflicts
      _bleScanSubscription?.cancel();
      _rssiUpdateTimer?.cancel();

      debugPrint('✅ Monitoring transferred to AddDeviceController');
      update();

      // Navigate to distance tracking screen
      Get.to(() => const DeviceDistanceTrackingScreen());

    } catch (e) {
      debugPrint('❌ Failed to start beacon monitoring: $e');
      errorLog("connectToBluetoothDevice", e);
      connectionStatus.value = 'Error';
      showCustomSnackBar(
        title: "Error",
        message: "Failed to connect to device",
      );
      update();
    }
  }

  Future<void> connectToDeviceByMacAddress(String macAddress, {required String deviceName}) async {
    try {
      debugPrint('🔗 Attempting to connect to device by MAC: $macAddress');

      // First, check if we already have this device in our discovered list
      if (_discoveredDevices.containsKey(macAddress)) {
        debugPrint('✅ Device found in cache, connecting...');
        await connectToBluetoothDevice(macAddress, deviceName);
        return;
      }

      // If not found, start scanning specifically for this device
      debugPrint('🔍 Device not in cache, starting targeted scan...');
      showCustomSnackBar(
        title: "Searching",
        message: "Looking for your device...",
      );

      bool deviceFound = false;

      _bleScanSubscription = _ble.scanForDevices(
        withServices: [],
        scanMode: ScanMode.lowLatency,
      ).listen(
            (device) {
          if (device.id.toUpperCase() == macAddress.toUpperCase()) {
            debugPrint('✅ Found target device: ${device.id}');
            _discoveredDevices[device.id] = device;
            deviceFound = true;

            // Connect to it
            _bleScanSubscription?.cancel();
            connectToBluetoothDevice(device.id, deviceName);
          }
        },
        onError: (error) {
          debugPrint('❌ Error scanning for device: $error');
          showCustomSnackBar(
            title: "Error",
            message: "Failed to find device",
          );
        },
      );

      // Timeout after 15 seconds
      Future.delayed(Duration(seconds: 15), () {
        if (!deviceFound && !isBluetoothConnected.value) {
          _bleScanSubscription?.cancel();
          showCustomSnackBar(
            title: "Not Found",
            message: "Could not find device. Make sure it's powered on and nearby.",
          );
        }
      });

    } catch (e) {
      debugPrint('❌ Failed to connect by MAC address: $e');
      errorLog("connectToDeviceByMacAddress", e);
      showCustomSnackBar(
        title: "Error",
        message: "Failed to connect to device",
      );
    }
  }
  double rssiToDistance(int rssi, {int txPower = -59, double n = 2.0}) {
    // txPower: measured RSSI at 1 meter
    // For Minew E8: typically -59 to -65 dBm at 1m
    // For Minew D15N: typically -55 to -60 dBm at 1m
    // n: path-loss exponent (2.0 = free space, 2.0-4.0 typical indoors)

    if (rssi == 0) {
      return -1.0; // Unknown distance
    }

    // Adjust txPower based on device type if needed
    int adjustedTxPower = txPower;
    if (connectedBleDevice.value?.name.contains('D15N') == true) {
      adjustedTxPower = -57; // D15N typically has stronger signal
    } else if (connectedBleDevice.value?.name.contains('E8') == true) {
      adjustedTxPower = -59; // E8 default
    }

    double ratio = (adjustedTxPower - rssi) / (10 * n);
    double distance = pow(10, ratio).toDouble();

    // Round to 2 decimal places
    return (distance * 100).roundToDouble() / 100;
  }
  void _startContinuousRssiMonitoring(String deviceId) {
    _rssiUpdateTimer?.cancel();
    _bleScanSubscription?.cancel();

    debugPrint('📡 Starting continuous RSSI monitoring for: $deviceId');

    DateTime lastUpdate = DateTime.now();
    int consecutiveFailures = 0;

    void startScan() {
      debugPrint('🔄 (Re)starting scan for beacon monitoring...');
      _bleScanSubscription?.cancel();

      // Start continuous scanning focused on this device
      _bleScanSubscription = _ble.scanForDevices(
        withServices: [],
        scanMode: ScanMode.lowLatency,
      ).listen(
            (device) {
          if (device.id == deviceId) {
            // Update RSSI and distance
            currentRssi.value = device.rssi;
            estimatedDistance.value = rssiToDistance(device.rssi);

            // Update the stored device info
            _discoveredDevices[deviceId] = device;
            connectedBleDevice.value = device;

            lastUpdate = DateTime.now();
            consecutiveFailures = 0; // Reset failure counter

            debugPrint('📊 Beacon Update - RSSI: ${device.rssi} dBm, Distance: ${estimatedDistance.value.toStringAsFixed(2)}m');
            update();
          }
        },
        onError: (error) {
          debugPrint('❌ RSSI monitoring error: $error');
          consecutiveFailures++;

          // If too many errors, try restarting scan
          if (consecutiveFailures >= 3 && isBluetoothConnected.value) {
            debugPrint('⚠️ Multiple scan errors, restarting scan...');
            Future.delayed(Duration(seconds: 2), () {
              if (isBluetoothConnected.value) {
                startScan();
              }
            });
          }
        },
      );
    }

    // Start initial scan
    startScan();

    // Periodic check and scan restart (every 15 seconds)
    _rssiUpdateTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (!isBluetoothConnected.value) {
        timer.cancel();
        _bleScanSubscription?.cancel();
        return;
      }

      final timeSinceLastUpdate = DateTime.now().difference(lastUpdate);

      if (timeSinceLastUpdate.inSeconds > 10) {
        debugPrint('⚠️ No beacon signal for ${timeSinceLastUpdate.inSeconds}s, restarting scan...');

        // Restart scan
        // startScan();

        // Show warning to user
        if (timeSinceLastUpdate.inSeconds > 20) {
          showCustomSnackBar(
            title: "Weak Signal",
            message: "Beacon signal lost. Move closer to device.",
          );
        }
      } else {
        debugPrint('✅ Beacon monitoring healthy. Last update: ${timeSinceLastUpdate.inSeconds}s ago');
      }
    });
  }

  // Fetch initial devices
  Future<void> getDevices() async {
    isLoading.value = true;
    try {
      final NetworkResponse response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        DeviceModel deviceModel = DeviceModel.fromJson(response.responseData);
        devices.clear();
        devices.addAll(deviceModel.data?.devices ?? []);
        totalPage = deviceModel.data?.pagination?.totalPage ?? 1;
        update();

      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch more devices for pagination
  Future<void> loadMoreDevices() async {
    if (currentPage == totalPage || isPaginationLoading.value) return; // Prevent further loading if no more pages or already loading

    isPaginationLoading.value = true;
    currentPage++;

    try {
      final NetworkResponse response = await apiCall(page: currentPage);
      if (response.isSuccess) {
        DeviceModel deviceModel = DeviceModel.fromJson(response.responseData);
        devices.addAll(deviceModel.data?.devices ?? []);
      } else {
        showCustomSnackBar(title: "Failed", message: response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPaginationLoading.value = false;
    }
  }

  // API call method with pagination support
  Future<dynamic> apiCall({int page = 1}) async {
    String? accessToken = await SaveDataController().getUserData();
    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getDevicesUrl,
      queryParam: {'page': page.toString()},
      accessToken: accessToken,
    );
    return response;
  }

  RxBool isDeleteLoading =  false.obs;

  Future<void>deleteDevice(String deviceId)async{
    isDeleteLoading.value = true;
    final NetworkResponse response = await _deleteDeviceApi(deviceId);
    isDeleteLoading.value = false;
    if(response.isSuccess){
      showCustomSnackBar(title: "success", message: "Device deactivate successfully");
      update();
    }else{
      showCustomSnackBar(title: "Failed", message: response.errorMessage);
    }
  }

  Future<dynamic> _deleteDeviceApi(String deviceId) async {
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(()=>SaveDataController());
    }
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = NetworkCaller().delRequest(
      Urls.deleteDeviceUrl(deviceId),
      accessToken: accessToken, body: {},
    );
    return response;
  }

  // Scroll listener to detect when to load more data
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreDevices(); // Trigger loading more devices when scrolled to the bottom
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  var profile = Get.find<AccountController>();

  // Select item logic as before
  void selectItem(int? value) {
    selectedItem.value = value ?? 1;
  }
  void stopBluetoothScan() {
    debugPrint('🛑 Stopping Bluetooth scan. Found ${_discoveredDevices.length} devices');
    _bleScanSubscription?.cancel();
    isBluetoothScanning.value = false;
    update();
  }
}
