# Bluetooth Device Connection and Distance Tracking Guide

## Overview
This guide explains how to connect to Minew Bluetooth devices (E8 and D15N) and track their distance in real-time.

## Features Implemented

### 1. Device Connection Status
- **Connection States**: Disconnected, Connecting, Connected, Disconnecting
- **Visual Indicators**: Color-coded status display
- **Real-time Updates**: Observable connection state changes

### 2. Distance Calculation
- **RSSI-based Distance**: Calculates distance from signal strength
- **Continuous Monitoring**: Updates every 1.5 seconds
- **Accuracy**: Calibrated for Minew E8 and D15N devices

### 3. Signal Strength Categories
- **Excellent**: ≥ -60 dBm (Very close)
- **Good**: -60 to -70 dBm (Close)
- **Fair**: -70 to -80 dBm (Medium)
- **Weak**: -80 to -90 dBm (Far)
- **Very Weak**: < -90 dBm (Very far)

## How to Use in Your UI

### Step 1: Check if Device is Connected

```dart
// In your widget
GetBuilder<AddDeviceController>(
  builder: (controller) {
    if (controller.isBluetoothConnected.value) {
      return Text('Device Connected!');
    } else {
      return Text('No device connected');
    }
  },
);
```

### Step 2: Display Connection Status

```dart
Obx(() => Text(
  'Status: ${controller.connectionStatus.value}',
  style: TextStyle(
    color: controller.connectionStatus.value == 'Connected' 
      ? Colors.green 
      : Colors.grey,
  ),
));
```

### Step 3: Show Device Information

```dart
GetBuilder<AddDeviceController>(
  builder: (controller) {
    final device = controller.connectedBleDevice.value;
    if (device == null) return SizedBox.shrink();
    
    return Column(
      children: [
        Text('Device Name: ${device.name}'),
        Text('MAC Address: ${device.id}'),
      ],
    );
  },
);
```

### Step 4: Display Real-time Distance

```dart
// Distance in meters
Obx(() => Text(
  'Distance: ${controller.estimatedDistance.value.toStringAsFixed(2)} m',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
));

// Distance category
Obx(() => Text(
  'Range: ${controller.getDistanceCategory(controller.estimatedDistance.value)}',
));
```

### Step 5: Show Signal Strength

```dart
// RSSI value
Obx(() => Text('RSSI: ${controller.currentRssi.value} dBm'));

// Signal quality
Obx(() => Text(
  'Signal: ${controller.getSignalStrength(controller.currentRssi.value)}',
));
```

### Step 6: Visual Distance Indicator

```dart
Obx(() {
  final distance = controller.estimatedDistance.value;
  final progress = (distance / 15.0).clamp(0.0, 1.0);
  
  return LinearProgressIndicator(
    value: 1.0 - progress,
    backgroundColor: Colors.grey[300],
    valueColor: AlwaysStoppedAnimation<Color>(
      distance < 1.0 ? Colors.green :
      distance < 3.0 ? Colors.lightGreen :
      distance < 7.0 ? Colors.orange :
      Colors.red,
    ),
  );
});
```

## Complete Example Screen

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/widgets/bluetooth_device_status_card.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/widgets/bluetooth_devices_list.dart';

class AddDeviceBluetoothScreen extends StatelessWidget {
  const AddDeviceBluetoothScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDeviceController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bluetooth Device'),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              controller.isBluetoothScanning.value 
                ? Icons.stop 
                : Icons.bluetooth_searching,
            ),
            onPressed: () {
              if (controller.isBluetoothScanning.value) {
                controller.stopBluetoothScan();
              } else {
                controller.startBluetoothScan();
              }
            },
          )),
        ],
      ),
      body: Column(
        children: [
          // Connection Status Card (shows when device is connected)
          const BluetoothDeviceStatusCard(),
          
          // Scanning Status
          Obx(() {
            if (controller.isBluetoothScanning.value) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(width: 16),
                    const Text('Scanning for devices...'),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          
          // Devices List
          Expanded(
            child: const BluetoothDevicesList(),
          ),
          
          // Connect Button (shown when device is connected)
          Obx(() {
            if (controller.isBluetoothConnected.value) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => controller.onTapConnectDevice(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Add Device'),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
```

## Distance Calculation Formula

The distance is calculated using the RSSI (Received Signal Strength Indicator) with the following formula:

```
distance = 10 ^ ((txPower - rssi) / (10 * n))
```

Where:
- **txPower**: Signal strength at 1 meter (calibrated per device)
  - Minew E8: -59 dBm
  - Minew D15N: -57 dBm
- **rssi**: Current signal strength
- **n**: Path-loss exponent (2.0 for free space, 2.0-4.0 indoors)

## Distance Categories

| Category | Distance Range | Description |
|----------|---------------|-------------|
| Very Close | < 1.0 m | Device is within arm's reach |
| Near | 1.0 - 3.0 m | Device is in the same room, nearby |
| Medium | 3.0 - 7.0 m | Device is in the same room, across |
| Far | 7.0 - 15.0 m | Device is in adjacent room or far end |
| Very Far | > 15.0 m | Device is multiple rooms away |

## Monitoring Events

### Listen to Connection Changes

```dart
// In your controller or widget
ever(controller.isBluetoothConnected, (isConnected) {
  if (isConnected) {
    print('Device connected!');
    // Perform actions when device connects
  } else {
    print('Device disconnected!');
    // Perform actions when device disconnects
  }
});
```

### Listen to Distance Changes

```dart
ever(controller.estimatedDistance, (distance) {
  print('Distance changed: $distance meters');
  
  // Trigger alerts based on distance
  if (distance > 10.0) {
    // Device is getting too far
    showAlert('Device is far away!');
  }
});
```

### Listen to RSSI Changes

```dart
ever(controller.currentRssi, (rssi) {
  print('Signal strength: $rssi dBm');
  
  // Check signal quality
  if (rssi < -90) {
    // Weak signal warning
    showWarning('Weak signal!');
  }
});
```

## Tips for Accurate Distance Measurement

1. **Calibration**: The default txPower values work for most scenarios, but you can calibrate for better accuracy:
   - Measure RSSI at exactly 1 meter distance
   - Update the txPower value in `rssiToDistance()` method

2. **Environment**: Distance accuracy is affected by:
   - Obstacles (walls, furniture)
   - Interference (other Bluetooth devices)
   - Device orientation
   - Battery level of the beacon

3. **Update Frequency**: The RSSI updates every 1.5 seconds. You can adjust this in `_startContinuousRssiMonitoring()`:
   ```dart
   Timer.periodic(Duration(milliseconds: 1500), (timer) { ... }
   ```

4. **Filtering**: For more stable readings, consider implementing a moving average:
   ```dart
   List<int> rssiHistory = [];
   
   void updateRssi(int newRssi) {
     rssiHistory.add(newRssi);
     if (rssiHistory.length > 5) rssiHistory.removeAt(0);
     int avgRssi = rssiHistory.reduce((a, b) => a + b) ~/ rssiHistory.length;
     currentRssi.value = avgRssi;
   }
   ```

## Troubleshooting

### Device Not Connecting
- Ensure Bluetooth permissions are granted
- Check if device is already connected to another phone
- Restart Bluetooth on your phone
- Make sure the beacon battery is not low

### Inaccurate Distance
- Move to an open area (reduce obstacles)
- Calibrate txPower for your specific device
- Implement RSSI filtering (moving average)
- Check for Bluetooth interference

### No Devices Found
- Verify device is powered on
- Check if device is in range (< 30m typically)
- Ensure location permission is granted (required for BLE scan)
- Restart the scan

## API Data Structure

When saving a device with Bluetooth connection, the following data is sent:

```json
{
  "name": "My Luggage",
  "category": "category_id",
  "serial": "device_mac_address",
  "connectionType": "bluetooth",
  "deviceMac": "AC:23:3F:A1:B2:C3",
  "deviceName": "Minew E8",
  "rssi": -65,
  "estimatedDistance": 2.45
}
```

This allows you to track connection history and analyze signal patterns over time.

