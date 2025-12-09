/// Minew Device Detection Troubleshooting Guide
///
/// Use this helper to identify which device in your scan is your Minew tracker

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class MinewDeviceDetector extends StatefulWidget {
  const MinewDeviceDetector({Key? key}) : super(key: key);

  @override
  State<MinewDeviceDetector> createState() => _MinewDeviceDetectorState();
}

class _MinewDeviceDetectorState extends State<MinewDeviceDetector> {
  final controller = Get.find<AddDeviceController>();
  String? selectedDeviceMac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minew Device Detector'),
        actions: [
          // Toggle to show ALL devices
          Obx(() => Switch(
            value: controller.showAllDevices.value,
            onChanged: (value) {
              controller.showAllDevices.value = value;
              if (value) {
                Get.snackbar(
                  'Debug Mode',
                  'Showing ALL nearby BLE devices',
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
          )),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Instructions card
          Card(
            margin: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'How to Find Your Minew Device',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('1. Turn ON the "Show All" switch above'),
                  const Text('2. Hold your Minew tracker VERY CLOSE to your phone'),
                  const Text('3. Tap "Start Scan"'),
                  const Text('4. Look for devices with RSSI > -60 (very close)'),
                  const Text('5. Tap on the strongest signal device'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.amber.shade100,
                    child: const Text(
                      '⚠️ Your Minew shows as "No Name" - use RSSI to identify it!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scan controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: controller.isBluetoothScanning.value
                        ? controller.stopBluetoothScan
                        : controller.startBluetoothScan,
                    icon: Icon(
                      controller.isBluetoothScanning.value
                          ? Icons.stop
                          : Icons.bluetooth_searching,
                    ),
                    label: Text(
                      controller.isBluetoothScanning.value
                          ? 'Stop Scan'
                          : 'Start Scan',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isBluetoothScanning.value
                          ? Colors.red
                          : Colors.blue,
                      minimumSize: const Size(0, 50),
                    ),
                  )),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Device list
          Expanded(
            child: Obx(() {
              final devices = controller.discoveredDevices;

              if (controller.isBluetoothScanning.value && devices.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Scanning for devices...'),
                    ],
                  ),
                );
              }

              if (devices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bluetooth_disabled, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('No devices found'),
                      const SizedBox(height: 8),
                      Text(
                        controller.showAllDevices.value
                            ? 'Make sure Bluetooth is on and device is nearby'
                            : 'Enable "Show All" to see nearby devices',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              // Sort by RSSI (strongest first)
              devices.sort((a, b) => b.rssi.compareTo(a.rssi));

              return ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  final isSelected = selectedDeviceMac == device.id;
                  final rssi = device.rssi;
                  final distance = controller.rssiToDistance(rssi);

                  // Determine if this is likely the user's device (very close)
                  final isVeryClose = rssi > -60;
                  final isClose = rssi > -70;

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    color: isSelected
                        ? Colors.blue.shade50
                        : isVeryClose
                            ? Colors.green.shade50
                            : isClose
                                ? Colors.yellow.shade50
                                : null,
                    child: ExpansionTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bluetooth,
                            color: isVeryClose
                                ? Colors.green
                                : isClose
                                    ? Colors.orange
                                    : Colors.grey,
                          ),
                          Text(
                            '#${index + 1}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      title: Text(
                        device.name.isEmpty ? 'Unknown Device' : device.name,
                        style: TextStyle(
                          fontWeight: isVeryClose ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MAC: ${device.id}'),
                          Row(
                            children: [
                              Text(
                                'RSSI: $rssi dBm',
                                style: TextStyle(
                                  color: isVeryClose
                                      ? Colors.green
                                      : isClose
                                          ? Colors.orange
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('~${distance.toStringAsFixed(1)}m'),
                              const SizedBox(width: 8),
                              if (isVeryClose)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'VERY CLOSE!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('MAC Address', device.id),
                              _buildDetailRow('Device Name', device.name.isEmpty ? 'Not advertised' : device.name),
                              _buildDetailRow('RSSI', '$rssi dBm (${controller.getSignalStrength(rssi)})'),
                              _buildDetailRow('Distance', '~${distance.toStringAsFixed(2)} meters'),
                              _buildDetailRow('Distance Category', controller.getDistanceCategory(distance)),

                              const Divider(),

                              // Manufacturer Data
                              if (device.manufacturerData.isNotEmpty) ...[
                                const Text(
                                  'Manufacturer Data:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(_formatManufacturerData(device.manufacturerData)),
                                const SizedBox(height: 8),
                              ],

                              // Service UUIDs
                              if (device.serviceUuids.isNotEmpty) ...[
                                const Text(
                                  'Services:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                ...device.serviceUuids.map((uuid) => Text('  • $uuid')),
                                const SizedBox(height: 8),
                              ],

                              const Divider(),

                              // Actions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        selectedDeviceMac = device.id;
                                      });
                                      Get.snackbar(
                                        'Selected',
                                        'MAC: ${device.id}',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    },
                                    icon: const Icon(Icons.check, size: 16),
                                    label: const Text('Mark as Mine'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.connectToBluetoothDevice(device.id);
                                    },
                                    icon: const Icon(Icons.bluetooth_connected, size: 16),
                                    label: const Text('Test Connect'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          // Selected device info
          if (selectedDeviceMac != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✅ Device Identified!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('MAC Address: $selectedDeviceMac'),
                  const SizedBox(height: 8),
                  const Text('Copy this MAC address and use it in your app!'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatManufacturerData(List<int> data) {
    if (data.isEmpty) return 'None';

    // Format as hex
    String hex = data.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');

    // Try to extract manufacturer ID (first 2 bytes, little-endian)
    String manufacturerInfo = '';
    if (data.length >= 2) {
      int manufacturerId = data[0] | (data[1] << 8);
      manufacturerInfo = '\nManufacturer ID: 0x${manufacturerId.toRadixString(16).toUpperCase().padLeft(4, '0')}';

      if (manufacturerId == 0x0059) {
        manufacturerInfo += ' (Minew! ✅)';
      }
    }

    return 'Hex: $hex$manufacturerInfo\nLength: ${data.length} bytes';
  }
}

