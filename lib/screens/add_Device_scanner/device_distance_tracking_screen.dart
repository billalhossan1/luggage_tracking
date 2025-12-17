import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';

class DeviceDistanceTrackingScreen extends StatelessWidget {
  const DeviceDistanceTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          // Disconnect when user presses back
          await controller.disconnectBluetoothDevice();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Distance Tracking'),
          backgroundColor: AppColors.instance.purple_100,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              // Disconnect when user presses back button
              await controller.disconnectBluetoothDevice();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: GetBuilder<AddDeviceController>(
          builder: (controller) {
            return Obx(() {
              if (!controller.isBluetoothConnected.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bluetooth_disabled, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Device Disconnected',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Please go back and connect again'),
                    ],
                  ),
                );
              }

              final device = controller.connectedBleDevice.value;
              final distance = controller.estimatedDistance.value;
              final rssi = controller.currentRssi.value;
              final distanceCategory = controller.getDistanceCategory(distance);
              final signalStrength = controller.getSignalStrength(rssi);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Connection Status Banner
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade400, Colors.green.shade600],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 24),
                          SizedBox(width: 12),
                          Text(
                            controller.connectionStatus.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32),

                    // Device Info Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Device Icon
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.instance.purple_100.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.bluetooth_connected,
                                  size: 64,
                                  color: AppColors.instance.purple_100,
                                ),
                              ),

                              SizedBox(height: 16),

                              // Device Name
                              Text(
                                device?.name ?? 'Unknown Device',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 8),

                              // MAC Address
                              Text(
                                device?.id ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    // Distance Display - Big and Prominent
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getDistanceColor(distance).withValues(alpha: 0.2),
                              _getDistanceColor(distance).withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _getDistanceColor(distance),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'DISTANCE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 16),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    distance >= 0
                                      ? distance.toStringAsFixed(2)
                                      : '--',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: _getDistanceColor(distance),
                                      height: 1,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      'meters',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: _getDistanceColor(distance),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: _getDistanceColor(distance),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                distanceCategory,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // Distance Visual Indicator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _getDistanceProgress(distance),
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getDistanceColor(distance),
                              ),
                              minHeight: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Very Close',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                              Text(
                                'Very Far',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32),

                    // Signal Strength Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.signal_cellular_alt,
                                size: 32,
                                color: _getSignalColor(rssi),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Signal Strength',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '$rssi dBm',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getSignalColor(rssi).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  signalStrength,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getSignalColor(rssi),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // Info Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        color: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Distance updates every 1.5 seconds. Move closer or farther to see real-time changes.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // Disconnect Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await controller.disconnectBluetoothDevice();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.bluetooth_disabled),
                          label: Text('Disconnect Device'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Color _getDistanceColor(double distance) {
    if (distance < 0) return Colors.grey;
    if (distance < 1.0) return Colors.green;
    if (distance < 3.0) return Colors.lightGreen;
    if (distance < 7.0) return Colors.orange;
    if (distance < 15.0) return Colors.deepOrange;
    return Colors.red;
  }

  Color _getSignalColor(int rssi) {
    if (rssi >= -60) return Colors.green;
    if (rssi >= -70) return Colors.lightGreen;
    if (rssi >= -80) return Colors.orange;
    if (rssi >= -90) return Colors.deepOrange;
    return Colors.red;
  }

  double _getDistanceProgress(double distance) {
    if (distance < 0) return 0.0;
    // Map 0-15 meters to 1.0-0.0 (inverted so full bar = close)
    double progress = 1.0 - (distance / 15.0).clamp(0.0, 1.0);
    return progress;
  }
}

