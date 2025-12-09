import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

/// Simple connection status indicator
class ConnectionStatusIndicator extends StatelessWidget {
  const ConnectionStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    return Obx(() {
      final status = controller.connectionStatus.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _getStatusColor(status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _getStatusColor(status),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getStatusIcon(status),
              size: 16,
              color: _getStatusColor(status),
            ),
            const SizedBox(width: 8),
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getStatusColor(status),
              ),
            ),
          ],
        ),
      );
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return Colors.green;
      case 'connecting...':
        return Colors.orange;
      case 'disconnecting...':
        return Colors.orange;
      case 'disconnected':
      case 'connection failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return Icons.check_circle;
      case 'connecting...':
        return Icons.refresh;
      case 'disconnecting...':
        return Icons.refresh;
      case 'disconnected':
      case 'connection failed':
        return Icons.error_outline;
      default:
        return Icons.bluetooth_disabled;
    }
  }
}

/// Compact distance display widget
class DistanceDisplay extends StatelessWidget {
  final bool showCategory;

  const DistanceDisplay({
    Key? key,
    this.showCategory = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    return Obx(() {
      if (!controller.isBluetoothConnected.value) {
        return const SizedBox.shrink();
      }

      final distance = controller.estimatedDistance.value;
      final category = controller.getDistanceCategory(distance);

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _getDistanceColor(distance).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.straighten,
              size: 16,
              color: _getDistanceColor(distance),
            ),
            const SizedBox(width: 8),
            Text(
              distance >= 0
                ? '${distance.toStringAsFixed(1)}m'
                : '---',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getDistanceColor(distance),
              ),
            ),
            if (showCategory) ...[
              const SizedBox(width: 8),
              Text(
                '($category)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      );
    });
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

/// RSSI signal strength indicator
class SignalStrengthIndicator extends StatelessWidget {
  const SignalStrengthIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    return Obx(() {
      if (!controller.isBluetoothConnected.value) {
        return const SizedBox.shrink();
      }

      final rssi = controller.currentRssi.value;
      final strength = controller.getSignalStrength(rssi);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSignalBar(rssi >= -90, _getSignalColor(rssi)),
          const SizedBox(width: 2),
          _buildSignalBar(rssi >= -80, _getSignalColor(rssi)),
          const SizedBox(width: 2),
          _buildSignalBar(rssi >= -70, _getSignalColor(rssi)),
          const SizedBox(width: 2),
          _buildSignalBar(rssi >= -60, _getSignalColor(rssi)),
          const SizedBox(width: 8),
          Text(
            strength,
            style: TextStyle(
              fontSize: 12,
              color: _getSignalColor(rssi),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSignalBar(bool isActive, Color activeColor) {
    return Container(
      width: 4,
      height: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
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

/// Combined status and distance widget
class BluetoothDeviceInfo extends StatelessWidget {
  const BluetoothDeviceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDeviceController>(
      builder: (controller) {
        if (!controller.isBluetoothConnected.value) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.connectedBleDevice.value?.name ?? 'Device',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const ConnectionStatusIndicator(),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SignalStrengthIndicator(),
                    const DistanceDisplay(showCategory: false),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

