import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

/// Widget to display discovered Bluetooth devices
class BluetoothDevicesList extends StatelessWidget {
  const BluetoothDevicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddDeviceController>(
      builder: (controller) {
        final devices = controller.discoveredDevices;

        if (devices.isEmpty && controller.isBluetoothScanning.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Scanning for Minew devices...'),
              ],
            ),
          );
        }

        if (devices.isEmpty && !controller.isBluetoothScanning.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bluetooth_searching, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('No devices found'),
                const SizedBox(height: 8),
                const Text(
                  'Make sure your Minew device is powered on',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return _buildDeviceCard(controller, device);
          },
        );
      },
    );
  }

  Widget _buildDeviceCard(AddDeviceController controller, DiscoveredDevice device) {
    final isConnected = controller.connectedBleDevice.value?.id == device.id;
    final distance = controller.rssiToDistance(device.rssi);
    final signalStrength = controller.getSignalStrength(device.rssi);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isConnected ? Colors.green : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildDeviceIcon(device, isConnected),
        title: Text(
          device.name.isNotEmpty ? device.name : 'Unknown Device',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'MAC: ${device.id}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.signal_cellular_alt, size: 14, color: _getSignalColor(device.rssi)),
                const SizedBox(width: 4),
                Text(
                  '${device.rssi} dBm ($signalStrength)',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                const SizedBox(width: 12),
                Icon(Icons.straighten, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '~${distance.toStringAsFixed(1)}m',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
            if (isConnected) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Obx(() => Text(
                  controller.connectionStatus.value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ],
          ],
        ),
        trailing: isConnected
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => controller.disconnectBluetoothDevice(),
        )
            : ElevatedButton(
          onPressed: controller.isBluetoothConnected.value
              ? null
              : () => controller.connectToBluetoothDevice(device.id),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Connect'),
        ),
      ),
    );
  }

  Widget _buildDeviceIcon(DiscoveredDevice device, bool isConnected) {
    IconData icon = Icons.bluetooth;
    Color color = Colors.blue;

    if (isConnected) {
      icon = Icons.bluetooth_connected;
      color = Colors.green;
    } else if (device.name.contains('E8')) {
      icon = Icons.bluetooth_searching;
      color = Colors.orange;
    } else if (device.name.contains('D15N')) {
      icon = Icons.bluetooth_searching;
      color = Colors.purple;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 32),
    );
  }

  Color _getSignalColor(int rssi) {
    if (rssi >= -60) return Colors.green;
    if (rssi >= -70) return Colors.lightGreen;
    if (rssi >= -80) return Colors.orange;
    if (rssi >= -90) return Colors.deepOrange;
    return Colors.red;
  }
}

