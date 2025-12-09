/// Quick Test Script for MAC Address Connection
///
/// Use this to verify the implementation is working

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

class MacConnectionTest extends StatelessWidget {
  const MacConnectionTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDeviceController());

    return Scaffold(
      appBar: AppBar(title: const Text('MAC Connection Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test 1: Scan for Devices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                debugPrint('🧪 TEST 1: Starting scan...');
                controller.startBluetoothScan();
              },
              child: const Text('Start Scan'),
            ),
            const SizedBox(height: 8),
            Obx(() => Text(
              'Status: ${controller.isBluetoothScanning.value ? "Scanning..." : "Not scanning"}',
            )),
            Obx(() => Text(
              'Devices found: ${controller.discoveredDevices.length}',
            )),

            const Divider(height: 32),

            const Text(
              'Test 2: Connect by MAC Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Replace with your device MAC:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                // TODO: Replace with actual MAC from your logs
                const testMac = "7A:98:C2:E7:11:A6";
                debugPrint('🧪 TEST 2: Connecting to MAC: $testMac');
                controller.connectToDeviceByMacAddress(testMac);
              },
              child: const Text('Test MAC Connection'),
            ),
            const SizedBox(height: 8),
            Obx(() => Text(
              'Connection: ${controller.connectionStatus.value}',
              style: TextStyle(
                color: controller.isBluetoothConnected.value
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )),

            const Divider(height: 32),

            const Text(
              'Test 3: Monitor RSSI Updates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (!controller.isBluetoothConnected.value) {
                return const Text('Not connected');
              }

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('✅ Connected to: ${controller.connectedBleDevice.value?.id}'),
                    const SizedBox(height: 8),
                    Text('RSSI: ${controller.currentRssi.value} dBm'),
                    Text('Distance: ${controller.estimatedDistance.value.toStringAsFixed(2)}m'),
                    Text('Signal: ${controller.getSignalStrength(controller.currentRssi.value)}'),
                    const SizedBox(height: 8),
                    const Text(
                      'This should update every second!',
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Divider(height: 32),

            const Text(
              'Expected Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('✅ Test 1: Should find nearby BLE devices'),
            const Text('✅ Test 2: Should connect using MAC address'),
            const Text('✅ Test 3: Should show live RSSI updates'),
            const SizedBox(height: 8),
            const Text(
              'Check console logs for detailed output!',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            // Cleanup
            ElevatedButton(
              onPressed: () {
                debugPrint('🧪 CLEANUP: Disconnecting...');
                controller.disconnectBluetoothDevice();
                controller.stopBluetoothScan();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Stop All & Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}

// Test from anywhere:
// Get.to(() => MacConnectionTest());

