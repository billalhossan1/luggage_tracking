import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

/// Example: How to connect to a device using its saved MAC address
///
/// This demonstrates reconnecting to a previously paired Minew beacon
/// using the MAC address that was saved to your backend database.

class DeviceReconnectionExample extends StatelessWidget {
  const DeviceReconnectionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    // Example: Device data retrieved from your backend API
    final String savedDeviceName = "My Luggage";
    final String savedDeviceMac = "AC:23:3F:12:34:56"; // From backend
    final String savedCategoryId = "category123";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconnect to Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display saved device info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Device',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Name: $savedDeviceName'),
                    Text('MAC Address: $savedDeviceMac'),
                    Text('Category: $savedCategoryId'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Method 1: Quick Connect Button
            ElevatedButton.icon(
              onPressed: () {
                // Connect directly using MAC address
                controller.connectToDeviceByMacAddress(
                  savedDeviceMac,
                  deviceName: savedDeviceName,
                );
              },
              icon: const Icon(Icons.bluetooth_connected),
              label: const Text('Quick Connect'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 16),

            // Method 2: Manual Scan & Connect
            ElevatedButton.icon(
              onPressed: () async {
                // Start scanning
                await controller.startBluetoothScan();

                // Wait a few seconds for devices to be discovered
                await Future.delayed(const Duration(seconds: 5));

                // Check if our device was found
                if (controller.discoveredDevices.any((d) => d.id == savedDeviceMac)) {
                  // Connect to it
                  controller.connectToBluetoothDevice(savedDeviceMac);
                } else {
                  Get.snackbar(
                    'Not Found',
                    'Device not found. Make sure it\'s powered on.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              icon: const Icon(Icons.search),
              label: const Text('Scan & Connect'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Connection status
            Obx(() => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: controller.isBluetoothConnected.value
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        controller.isBluetoothConnected.value
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: controller.isBluetoothConnected.value
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Status: ${controller.connectionStatus.value}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  if (controller.isBluetoothConnected.value) ...[
                    const SizedBox(height: 12),
                    Text('Device: ${controller.connectedBleDevice.value?.name ?? "Unknown"}'),
                    Text('MAC: ${controller.connectedBleDevice.value?.id ?? "N/A"}'),
                    Text('RSSI: ${controller.currentRssi.value} dBm'),
                    Text('Distance: ${controller.estimatedDistance.value.toStringAsFixed(2)}m'),
                    Text('Signal: ${controller.getSignalStrength(controller.currentRssi.value)}'),

                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => controller.disconnectBluetoothDevice(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Disconnect'),
                    ),
                  ],
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}


/// Example: Integrate MAC connection in your device list
///
/// This shows how to add "Reconnect" buttons to your existing devices
class DeviceListWithReconnect extends StatelessWidget {
  const DeviceListWithReconnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    // Example: List of devices from your backend
    final devices = [
      {'name': 'My Suitcase', 'mac': 'AC:23:3F:12:34:56', 'category': 'Luggage'},
      {'name': 'Backpack', 'mac': '7A:98:C2:E7:11:A6', 'category': 'Bag'},
      {'name': 'Laptop Bag', 'mac': '40:1B:60:6C:3F:A7', 'category': 'Bag'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Devices'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.luggage, size: 40),
              title: Text(device['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${device['category']}'),
                  Text(
                    'MAC: ${device['mac']}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Connect using saved MAC address
                  controller.connectToDeviceByMacAddress(
                    device['mac'] as String,
                    deviceName: device['name'] as String,
                  );
                },
                child: const Text('Connect'),
              ),
            ),
          );
        },
      ),
    );
  }
}


/// Example: Auto-reconnect on app start
///
/// This demonstrates automatically reconnecting to the last used device
class AutoReconnectExample {
  static Future<void> reconnectToLastDevice() async {
    final controller = Get.find<AddDeviceController>();

    // Get last connected device from local storage or backend
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // final lastMac = prefs.getString('last_connected_mac');

    final String? lastMac = "AC:23:3F:12:34:56"; // Example

    if (lastMac != null && lastMac.isNotEmpty) {
      debugPrint('🔄 Auto-reconnecting to last device: $lastMac');

      // Attempt to reconnect
      await controller.connectToDeviceByMacAddress(lastMac);
    }
  }
}


/// Example: Batch connect multiple devices
///
/// For users with multiple Minew trackers
class MultiDeviceConnectionExample {
  static Future<void> connectMultipleDevices(List<String> macAddresses) async {
    final controller = Get.find<AddDeviceController>();

    debugPrint('📡 Connecting to ${macAddresses.length} devices...');

    for (var mac in macAddresses) {
      try {
        await controller.connectToDeviceByMacAddress(mac);

        // Wait a bit between connections
        await Future.delayed(const Duration(seconds: 2));

      } catch (e) {
        debugPrint('❌ Failed to connect to $mac: $e');
      }
    }
  }
}

