import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

/// Widget to display Bluetooth device connection status and distance
class BluetoothDeviceStatusCard extends StatelessWidget {
  const BluetoothDeviceStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddDeviceController>(
      builder: (controller) {
        if (!controller.isBluetoothConnected.value) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Device Name and Status
                Row(
                  children: [
                    Icon(
                      Icons.bluetooth_connected,
                      color: Colors.green,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.connectedBleDevice.value?.name ?? 'Unknown Device',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(() => Text(
                            controller.connectionStatus.value,
                            style: TextStyle(
                              fontSize: 14,
                              color: _getStatusColor(controller.connectionStatus.value),
                            ),
                          )),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => controller.disconnectBluetoothDevice(),
                    ),
                  ],
                ),
                const Divider(height: 24),

                // Device MAC Address
                _buildInfoRow(
                  icon: Icons.fingerprint,
                  label: 'MAC Address',
                  value: controller.connectedBleDevice.value?.id ?? 'Unknown',
                ),
                const SizedBox(height: 12),

                // RSSI Value
                Obx(() => _buildInfoRow(
                  icon: Icons.signal_cellular_alt,
                  label: 'Signal Strength',
                  value: '${controller.currentRssi.value} dBm (${controller.getSignalStrength(controller.currentRssi.value)})',
                )),
                const SizedBox(height: 12),

                // Estimated Distance
                Obx(() => _buildDistanceRow(
                  controller.estimatedDistance.value,
                  controller.getDistanceCategory(controller.estimatedDistance.value),
                )),
                const SizedBox(height: 16),

                // Distance Visual Indicator
                Obx(() => _buildDistanceIndicator(controller.estimatedDistance.value)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceRow(double distance, String category) {
    return Row(
      children: [
        Icon(Icons.straighten, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(
          'Distance: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            distance >= 0 ? '${distance.toStringAsFixed(2)} m ($category)' : 'Calculating...',
            style: TextStyle(
              fontSize: 14,
              color: _getDistanceColor(distance),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceIndicator(double distance) {
    // Calculate progress (0-15 meters mapped to 0-1)
    double progress = (distance / 15.0).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distance Indicator',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 1.0 - progress, // Invert so full bar = close
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(_getDistanceColor(distance)),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Close',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            Text(
              'Far',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return Colors.green;
      case 'connecting...':
        return Colors.orange;
      case 'disconnected':
        return Colors.red;
      case 'disconnecting...':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getDistanceColor(double distance) {
    if (distance < 0) return Colors.grey;
    if (distance < 1.0) return Colors.green;
    if (distance < 3.0) return Colors.lightGreen;
    if (distance < 7.0) return Colors.orange;
    if (distance < 15.0) return Colors.deepOrange;
    return Colors.red;
  }
}

