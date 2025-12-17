// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luggage_tracking/const/urls/urls.dart';
// import 'package:luggage_tracking/routes/app_routes.dart';
// import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
// import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
// import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
// import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
// import 'package:luggage_tracking/services/api/network_caller.dart';
// import 'package:luggage_tracking/services/api/network_response.dart';
// import 'package:luggage_tracking/services/save_data/save_data.dart';
// import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/device_distance_tracking_screen.dart';
import 'package:luggage_tracking/screens/device_screen/controller/device_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/controller/home_screen_controller.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/widgets/camera_use/camera_use_permission_dialog.dart';
import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDeviceController extends GetxController {
  final TextEditingController itemNameController = TextEditingController();
  final MobileScannerController scannerController = MobileScannerController();

  // Bluetooth related
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _bleScanSubscription;
  StreamSubscription<ConnectionStateUpdate>? _bleConnectionSubscription;
  final RxMap<String, DiscoveredDevice> _discoveredDevices = <String, DiscoveredDevice>{}.obs;
  Rx<DiscoveredDevice?> connectedBleDevice = Rx<DiscoveredDevice?>(null);
  RxInt currentRssi = 0.obs;
  RxDouble estimatedDistance = 0.0.obs;
  RxBool isBluetoothScanning = false.obs;
  RxBool isBluetoothConnected = false.obs;
  RxString connectionStatus = 'Disconnected'.obs;
  Timer? _rssiUpdateTimer;

  // Existing fields
  List<CategoryItem> categoryList = [];
  final List<String> categories = [];
  RxString selectedCatId = ''.obs;
  RxString selectedCatName = ''.obs;
  RxBool isLoading = false.obs;
  bool termsAgreed = false;
  String? scannedDeviceId;
  RxBool isCameraPermissionGranted = false.obs;

  // Connection method selector
  RxString connectionMethod = 'qr'.obs; // 'qr' or 'bluetooth'

  // Debug mode: Show ALL Bluetooth devices (not just Minew)
  RxBool showAllDevices = false.obs;

  @override
  void onInit() {
    HomeScreenController homeScreenController = Get.find<HomeScreenController>();
    categoryList = homeScreenController.categoryList;
    for (var cat in categoryList) {
      categories.add(cat.name!);
    }
    _requestBluetoothPermissions();
    super.onInit();
  }

  @override
  void onClose() {
    itemNameController.dispose();
    scannerController.dispose();
    _bleScanSubscription?.cancel();
    _bleConnectionSubscription?.cancel();
    _rssiUpdateTimer?.cancel();
    super.onClose();
  }

  // Request Bluetooth permissions
  Future<void> _requestBluetoothPermissions() async {
    try {
      await Permission.location.request();
      await Permission.bluetooth.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
      debugPrint('✅ Bluetooth permissions requested');
    } catch (e) {
      debugPrint('❌ Error requesting Bluetooth permissions: $e');
      errorLog("_requestBluetoothPermissions", e);
    }
  }

  // Check if Bluetooth is available and enabled
  Future<bool> _checkBluetoothStatus() async {
    try {
      final status = await _ble.statusStream.first.timeout(Duration(seconds: 5));
      debugPrint('📡 Bluetooth status: $status');

      if (status == BleStatus.ready) {
        return true;
      } else if (status == BleStatus.poweredOff) {
        showCustomSnackBar(
          title: "Bluetooth Off",
          message: "Please turn on Bluetooth and try again",
        );
        return false;
      } else if (status == BleStatus.unauthorized) {
        showCustomSnackBar(
          title: "Permission Denied",
          message: "Please grant Bluetooth permissions in settings",
        );
        return false;
      } else {
        showCustomSnackBar(
          title: "Bluetooth Unavailable",
          message: "Bluetooth is not available: $status",
        );
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error checking Bluetooth status: $e');
      return true; // Proceed anyway
    }
  }

  // Calculate distance from RSSI with improved accuracy for Minew devices
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

  // Get distance category (Near, Medium, Far)
  String getDistanceCategory(double distance) {
    if (distance < 0) return 'Unknown';
    if (distance < 1.0) return 'Very Close';
    if (distance < 3.0) return 'Near';
    if (distance < 7.0) return 'Medium';
    if (distance < 15.0) return 'Far';
    return 'Very Far';
  }

  // Get signal strength category
  String getSignalStrength(int rssi) {
    if (rssi >= -60) return 'Excellent';
    if (rssi >= -70) return 'Good';
    if (rssi >= -80) return 'Fair';
    if (rssi >= -90) return 'Weak';
    return 'Very Weak';
  }

  // Start Bluetooth scan for Minew devices
  Future<void> startBluetoothScan() async {
    try {
      // Check Bluetooth status first
      bool isBluetoothReady = await _checkBluetoothStatus();
      if (!isBluetoothReady) {
        debugPrint('❌ Bluetooth not ready, aborting scan');
        return;
      }

      _discoveredDevices.clear();
      _bleScanSubscription?.cancel();
      isBluetoothScanning.value = true;

      debugPrint('🔍 Starting Bluetooth scan for Minew devices...');

      _bleScanSubscription = _ble.scanForDevices(
        withServices: [],
        scanMode: ScanMode.lowLatency,
      ).listen(
            (device) {
          // Debug: Print ALL discovered devices to see what's being found
          debugPrint('📱 Found device: ${device.name.isEmpty ? "No Name" : device.name} | ID: ${device.id} | RSSI: ${device.rssi}');

          // Print manufacturer data and service UUIDs for debugging
          if (device.manufacturerData.isNotEmpty) {
            debugPrint('   📦 Manufacturer Data: ${device.manufacturerData}');
          }
          if (device.serviceUuids.isNotEmpty) {
            debugPrint('   🔧 Services: ${device.serviceUuids}');
          }

          // More flexible filtering for Minew devices
          bool isMinewDevice = false;
          String matchReason = '';

          // Check device name (case-insensitive)
          String deviceNameLower = device.name.toLowerCase();
          if (deviceNameLower.contains('e8') ||
              deviceNameLower.contains('d15n') ||
              deviceNameLower.contains('d15') ||
              deviceNameLower.contains('minew') ||
              deviceNameLower.contains('minewtech')) {
            isMinewDevice = true;
            matchReason = 'NAME: ${device.name}';
          }

          // Check MAC address pattern (Minew devices often start with specific prefixes)
          String macUpper = device.id.toUpperCase();
          if (macUpper.contains('2ABU6') ||
              macUpper.startsWith('AC:23:3F') ||  // Common Minew prefix
              macUpper.startsWith('A4:C1:38') ||  // Another Minew prefix
              macUpper.startsWith('FC:A2:5F')) {  // Additional Minew prefix
            isMinewDevice = true;
            matchReason = 'MAC: ${device.id}';
          }

          // Check manufacturer data (Minew manufacturer ID is 0x0059 = 89 decimal)
          if (device.manufacturerData.isNotEmpty) {
            debugPrint('   📦 Manufacturer Data Length: ${device.manufacturerData.length} bytes');
            // Print raw bytes for analysis
            String hexData = device.manufacturerData.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
            debugPrint('   📦 Manufacturer Data (hex): $hexData');

            // Check if data starts with Minew manufacturer ID (0x59 0x00 in little-endian)
            if (device.manufacturerData.length >= 2) {
              int manufacturerId = device.manufacturerData[0] | (device.manufacturerData[1] << 8);
              debugPrint('   📊 Manufacturer ID: 0x${manufacturerId.toRadixString(16).toUpperCase().padLeft(4, '0')}');

              if (manufacturerId == 0x0059 || manufacturerId == 89) {
                isMinewDevice = true;
                matchReason = 'Manufacturer Data (Minew ID: 0x0059)';
              }
            }
          }

          // Check service UUIDs for Minew-specific services
          for (var uuid in device.serviceUuids) {
            String uuidStr = uuid.toString().toLowerCase();
            // Common Minew service UUIDs
            if (uuidStr.contains('ffe0') ||  // Minew custom service
                uuidStr.contains('ffe1') ||
                uuidStr.contains('fff0')) {
              isMinewDevice = true;
              matchReason = 'Service UUID: $uuid';
            }
          }

          // TEMPORARY: For testing, accept devices with strong signal (close to you)
          // This helps you find your device - REMOVE THIS AFTER FINDING YOUR DEVICE!
          if (showAllDevices.value && device.rssi > -75) {
            isMinewDevice = true;
            matchReason = 'SHOW ALL MODE (RSSI: ${device.rssi})';
            debugPrint('   ⚠️ DEBUG MODE: Showing device due to showAllDevices mode');
          }

          if (isMinewDevice) {
            _discoveredDevices[device.id] = device;
            currentRssi.value = device.rssi;
            estimatedDistance.value = rssiToDistance(device.rssi);
            debugPrint('✅ Match by $matchReason');
            debugPrint('✅ Added Minew device: ${device.name.isEmpty ? "Unnamed" : device.name} (${device.id})');
            update();
          } else {
            // Log why device was filtered out (helps debugging)
            if (device.rssi > -70) {  // Only log nearby devices to reduce noise
              debugPrint('   ⚠️ Filtered out - No Minew match');
            }
          }
        },
        onError: (error) {
          debugPrint('❌ Bluetooth scan error: $error');
          errorLog("startBluetoothScan", error);
          showCustomSnackBar(
            title: "Bluetooth Error",
            message: "Failed to scan for devices: $error",
          );
          isBluetoothScanning.value = false;
        },
      );

      // Auto-stop scan after 60 seconds (increased from 30)
      Future.delayed(Duration(seconds: 60), () {
        if (isBluetoothScanning.value) {
          debugPrint('⏱️ Auto-stopping scan after 60 seconds');
          stopBluetoothScan();
        }
      });
    } catch (e) {
      debugPrint('❌ Failed to start Bluetooth scan: $e');
      errorLog("startBluetoothScan", e);
      isBluetoothScanning.value = false;
      showCustomSnackBar(
        title: "Error",
        message: "Failed to start Bluetooth scan",
      );
    }
  }

  // Stop Bluetooth scan
  void stopBluetoothScan() {
    debugPrint('🛑 Stopping Bluetooth scan. Found ${_discoveredDevices.length} devices');
    _bleScanSubscription?.cancel();
    isBluetoothScanning.value = false;
    update();
  }

  // Connect to a Bluetooth device (for beacons, this just starts monitoring)
  Future<void> connectToBluetoothDevice(String deviceId) async {
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
        message: "Connected to ${device.name.isEmpty ? 'beacon device' : device.name}",
      );

      // Start continuous monitoring of this specific beacon
      _startContinuousRssiMonitoring(deviceId);

      debugPrint('✅ Beacon monitoring started for: $deviceId');
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

  // Connect to a device using MAC address (useful for reconnecting to saved devices)
  Future<void> connectToDeviceByMacAddress(String macAddress, {String? deviceName}) async {
    try {
      debugPrint('🔗 Attempting to connect to device by MAC: $macAddress');

      // First, check if we already have this device in our discovered list
      if (_discoveredDevices.containsKey(macAddress)) {
        debugPrint('✅ Device found in cache, connecting...');
        await connectToBluetoothDevice(macAddress);
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
            connectToBluetoothDevice(device.id);
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

  // Monitor RSSI continuously for distance calculation (for beacon devices)
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
        startScan();

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

  // Disconnect from Bluetooth device
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

  // Public method to start monitoring when connected from another controller
  void startMonitoringFromExternalController(String deviceId) {
    debugPrint('🔄 Starting monitoring from external controller for: $deviceId');

    // Add the connected device to the discovered devices map if not already there
    if (connectedBleDevice.value != null && !_discoveredDevices.containsKey(deviceId)) {
      _discoveredDevices[deviceId] = connectedBleDevice.value!;
    }

    _startContinuousRssiMonitoring(deviceId);
  }

  // Transfer device from external controller
  void transferDeviceFromExternalController(String deviceId, DiscoveredDevice device) {
    debugPrint('📲 Transferring device from external controller: $deviceId');
    _discoveredDevices[deviceId] = device;
    connectedBleDevice.value = device;
  }

  // Get list of discovered devices
  List<DiscoveredDevice> get discoveredDevices => _discoveredDevices.values.toList();

  // Switch connection method
  void setConnectionMethod(String method) {
    connectionMethod.value = method;

    // Reset states when switching
    if (method == 'qr') {
      disconnectBluetoothDevice();
      stopBluetoothScan();
    } else {
      scannedDeviceId = null;
      isCameraPermissionGranted.value = false;
    }
    update();
  }

  String getCatIdFromName(String catName) {
    final category = categoryList.firstWhere(
          (cat) => cat.name == catName,
      orElse: () => CategoryItem(sId: '', name: ''),
    );
    return category.sId ?? '';
  }

  // Validation method
  bool validateInput() {
    if (itemNameController.text.trim().isEmpty) {
      showCustomSnackBar(title: "Error", message: "Device name cannot be empty.");
      return false;
    }

    if (selectedCatId.value.isEmpty) {
      showCustomSnackBar(title: "Error", message: "Please select a category.");
      return false;
    }

    if (connectionMethod.value == 'bluetooth' && !isBluetoothConnected.value) {
      showCustomSnackBar(title: "Error", message: "Please connect to a Bluetooth device first.");
      return false;
    }

    if (connectionMethod.value == 'qr' && scannedDeviceId == null) {
      showCustomSnackBar(title: "Error", message: "Please scan a QR code first.");
      return false;
    }

    if (!termsAgreed) {
      showCustomSnackBar(title: "Error", message: "You must agree to the terms.");
      return false;
    }

    return true;
  }

  // API call method
  Future<dynamic> apiCall() async {
    // bool isSubscribe = Get.find<AccountController>().profileModel.value?.isSubscribed ?? false;
    //TODO: Remove subscription check for testing
    bool isSubscribe = true;
    if (isSubscribe == false) {
      int length = Get.find<DeviceScreenController>().devices.length;
      if (length > 0) {
        return showPremiumPurchaseDialog();
      }
    }

    Map<String, dynamic> body = {
      "name": itemNameController.text.trim(),
      "category": selectedCatId.value,
      "serial": scannedDeviceId ?? "unknown",
      "connectionType": connectionMethod.value,
      if (connectionMethod.value == 'bluetooth') ...{
        "deviceMac": connectedBleDevice.value?.id,
        // "deviceName": connectedBleDevice.value?.name,
        // "rssi": currentRssi.value,
        // "estimatedDistance": estimatedDistance.value,
      }else...{
        "deviceMac": scannedDeviceId,
      }
    };
    print("=====================apiBody:$body");

    isLoading.value = true;
    String? accessToken = await SaveDataController().getUserData();
    NetworkResponse response = await NetworkCaller().postRequest(
      Urls.getDevicesUrl,
      body: body,
      accessToken: accessToken,
    );
    isLoading.value = false;
    return response;
  }

  Future<void> onTapConnectDevice() async {
    // For Bluetooth connection - already connected, just navigate
    if (connectionMethod.value == 'bluetooth' && isBluetoothConnected.value) {
      showCustomSnackBar(
        title: "Success",
        message: "Device Connected - Showing Distance Tracking",
      );

      // Navigate to distance tracking screen (already navigated in connectToBluetoothDevice)
      // If not already navigated, do it here:
      if (Get.currentRoute != '/DeviceDistanceTrackingScreen') {
        Get.to(() => const DeviceDistanceTrackingScreen());
      }
      return;
    }

    // For QR code method - connect using scanned MAC address
    if (connectionMethod.value == 'qr') {
      // Basic validation
      if (scannedDeviceId == null || scannedDeviceId!.isEmpty) {
        showCustomSnackBar(title: "Error", message: "Please scan a QR code first.");
        return;
      }

      // // Connect to device using scanned MAC address
      // debugPrint('🔗 QR Code scanned: $scannedDeviceId - Connecting via Bluetooth...');
      //
      // showCustomSnackBar(
      //   title: "Connecting",
      //   message: "Connecting to device via Bluetooth...",
      // );
      if (!validateInput()) {
        return;
      }

      final NetworkResponse response = await apiCall();

      if (response.isSuccess) {
        showCustomSnackBar(
          title: "Success",
          message: response.responseData["message"] ?? "Device Added Successfully",
        );

        // Clean up
        // if (connectionMethod.value == 'bluetooth') {
        //   disconnectBluetoothDevice();
        // }

        Get.find<DeviceScreenController>().getDevices();
        Navigator.pop(Get.context!); // Navigate back after successful connection
      } else {
        showCustomSnackBar(title: "Failed", message: response.errorMessage);
      }

      // Use the scanned device ID (MAC address) to connect
      // await connectToDeviceByMacAddress(scannedDeviceId!);
      // await connectToDeviceByMacAddress("C3:00:00:5E:32:AF");

      // return;
    }

    // Original API call (commented out for testing)
    /*
    if (!validateInput()) {
      return;
    }

    final NetworkResponse response = await apiCall();

    if (response.isSuccess) {
      showCustomSnackBar(
        title: "Success",
        message: response.responseData["message"] ?? "Device Connected Successfully",
      );

      // Clean up
      if (connectionMethod.value == 'bluetooth') {
        disconnectBluetoothDevice();
      }

      Get.find<DeviceScreenController>().getDevices();
      Get.back(); // Navigate back after successful connection
    } else {
      showCustomSnackBar(title: "Failed", message: response.errorMessage);
    }
    */
  }

  Future<void> requestCameraPermission() async {
    try {
      var response = await customCameraPermissionDialog();

      if (response) {
        isCameraPermissionGranted.value = true;
      } else {
        isCameraPermissionGranted.value = false;
      }

      update();
    } catch (e) {
      errorLog("requestCameraPermission", e);
    }
  }

  // Show the Premium Subscription Dialog
  Future<void> showPremiumPurchaseDialog() async {
    if (!Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => SaveDataController());
    }
    String? name = await SaveDataController().getUserName();
    String? email = await SaveDataController().getUserEmail();
    String? token = await SaveDataController().getUserData();
    return Get.dialog(
      AlertDialog(
        title: Text('Premium Membership Required'),
        content: Text(
          'To add more devices, you need to purchase the premium membership. Do you want to purchase now?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
              Get.toNamed(
                AppRoutes.instance.subPlanScreen,
                arguments: {"email": email, "name": name, "token": token},
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}



// import 'package:luggage_tracking/widgets/camera_use/camera_use_permission_dialog.dart';
// import 'package:luggage_tracking/widgets/snackbar_message/snack_bar_widget.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class AddDeviceController extends GetxController {
//   final TextEditingController itemNameController = TextEditingController();
//   final MobileScannerController scannerController = MobileScannerController();
//   List<CategoryItem> categoryList = [];
//   final List<String> categories = [];
//   RxString selectedCatId = ''.obs;
//   RxString selectedCatName = ''.obs;
//   RxBool isLoading = false.obs;
//   bool termsAgreed = false;
//   String? scannedDeviceId;
//
//   RxBool isCameraPermissionGranted = false.obs;
//
//   @override
//   void onInit() {
//     HomeScreenController homeScreenController = Get.find<HomeScreenController>();
//     categoryList = homeScreenController.categoryList;
//     for (var cat in categoryList) {
//       categories.add(cat.name!);
//     }
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     itemNameController.dispose();
//     scannerController.dispose();
//     super.onClose();
//   }
//
//   String getCatIdFromName(String catName) {
//     final category = categoryList.firstWhere(
//       (cat) => cat.name == catName,
//       orElse: () => CategoryItem(sId: '', name: ''),
//     );
//     return category.sId ?? '';
//   }
//
//   // Validation method
//   bool validateInput() {
//     if (itemNameController.text.trim().isEmpty) {
//       showCustomSnackBar(title: "Error", message: "Device name cannot be empty.");
//       return false;
//     }
//
//     if (selectedCatId.value.isEmpty) {
//       showCustomSnackBar(title: "Error", message: "Please select a category.");
//       return false;
//     }
//
//     if (!termsAgreed) {
//       showCustomSnackBar(title: "Error", message: "You must agree to the terms.");
//       return false;
//     }
//
//     return true;
//   }
//
//   // API call method
//   Future<dynamic> apiCall() async {
//     bool isSubscribe = Get.find<AccountController>().profileModel.value?.isSubscribed ?? false;
//     if (isSubscribe == false) {
//       int length = Get.find<DeviceScreenController>().devices.length;
//       if (length > 0) {
//         return showPremiumPurchaseDialog();
//       }
//     }
//
//     Map<String, dynamic> body = {
//       "name": itemNameController.text.trim(),
//       "category": selectedCatId.value,
//       "serial": "ffffv",
//     };
//     isLoading.value = true;
//     String? accessToken = await SaveDataController().getUserData();
//     NetworkResponse response = await NetworkCaller().postRequest(Urls.getDevicesUrl, body: body, accessToken: accessToken);
//     isLoading.value = false;
//     return response;
//   }
//
//   Future<void> onTapConnectDevice() async {
//     if (!validateInput()) {
//       return;
//     }
//
//     final NetworkResponse response = await apiCall();
//
//     if (response.isSuccess) {
//       showCustomSnackBar(title: "Success", message: response.responseData["message"] ?? "Device Connected Successfully");
//       Get.find<DeviceScreenController>().getDevices();
//       update();
//     } else {
//       showCustomSnackBar(title: "Failed", message: response.errorMessage);
//     }
//   }
//
//   Future<void> requestCameraPermission() async {
//     try {
//       var response = await customCameraPermissionDialog();
//
//       if (response) {
//         isCameraPermissionGranted.value = true;
//       } else {
//         isCameraPermissionGranted.value = false;
//       }
//
//       update();
//     } catch (e) {
//       errorLog("requestCameraPermission", e);
//     }
//   }
//
//   // Future<void> requestCameraPermission(BuildContext context) async {
//   //   if (_isRequestingPermission) return;
//   //   _isRequestingPermission = true;
//   //   final confirm = await showDialog<bool>(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Camera Permission'),
//   //       content: const Text('Camera permission is required to scan. Do you want to continue?'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.of(context).pop(false),
//   //           child: const Text('Cancel'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () => Navigator.of(context).pop(true),
//   //           child: const Text('Continue'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   //   if (confirm != true) {
//   //     _isRequestingPermission = false;
//   //     return;
//   //   }
//   //   var status = await Permission.camera.status;
//   //   if (!status.isGranted) {
//   //     status = await Permission.camera.request();
//   //   }
//   //   if (status.isGranted) {
//   //     isCameraPermissionGranted.value = true;
//   //     scannerController.start();
//   //   } else if (status.isPermanentlyDenied) {
//   //     bool? openSettings = await showDialog<bool>(
//   //       context: Get.context!,
//   //       builder: (context) => AlertDialog(
//   //         title: const Text('Permission Required for scan your device'),
//   //         content: const Text('Camera permission is required to proceed. Would you like to open the settings to enable it?'),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.of(context).pop(false),
//   //             child: const Text('No'),
//   //           ),
//   //           TextButton(
//   //             onPressed: () => Navigator.of(context).pop(true),
//   //             child: const Text('Yes'),
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //     if (openSettings == true) {
//   //       await openAppSettings();
//   //     }
//   //   } else {
//   //     ScaffoldMessenger.of(Get.context!).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Camera permission is required to scan.'),
//   //       ),
//   //     );
//   //   }
//   //   _isRequestingPermission = false;
//   // }
//
//   // Show the Premium Subscription Dialog
//   Future<void> showPremiumPurchaseDialog() async {
//     if (!Get.isRegistered<SaveDataController>()) {
//       Get.lazyPut(() => SaveDataController());
//     }
//     String? name = await SaveDataController().getUserName();
//     String? email = await SaveDataController().getUserEmail();
//     String? token = await SaveDataController().getUserData();
//     return Get.dialog(
//       AlertDialog(
//         title: Text('Premium Membership Required'),
//         content: Text('To add more devices, you need to purchase the premium membership. Do you want to purchase now?'),
//         actions: [
//           // No button - dismiss the dialog
//           TextButton(
//             onPressed: () {
//               Navigator.pop(Get.context!);
//             },
//             child: Text('No'),
//           ),
//           // Yes button - handle purchase logic here
//           TextButton(
//             onPressed: () {
//               Navigator.pop(Get.context!);
//
//               Get.toNamed(AppRoutes.instance.subPlanScreen, arguments: {"email": email, "name": name, "token": token});
//             },
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );
//   }
// }
