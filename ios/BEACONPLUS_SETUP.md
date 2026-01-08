# BeaconPlus SDK Setup for iOS

## Manual Framework Setup (Required)

Since the BeaconPlus frameworks are local, you need to manually add them to your Xcode project:

### Step 1: Open Xcode Project
```bash
open ios/Runner.xcworkspace
```

### Step 2: Add Frameworks to Project

1. In Xcode, select the **Runner** project in the Project Navigator
2. Select the **Runner** target
3. Go to the **General** tab
4. Scroll down to **Frameworks, Libraries, and Embedded Content**
5. Click the **+** button
6. Click **Add Other** → **Add Files...**
7. Navigate to `ios/Framworks/` folder
8. Select all three frameworks:
   - `MTBeaconPlus.framework`
   - `iOSDFULibrary.framework`
   - `ZIPFoundation.framework`
9. Make sure **"Embed & Sign"** is selected for each framework
10. Click **Add**

### Step 3: Add Framework Search Paths

1. Still in the **Runner** target settings
2. Go to the **Build Settings** tab
3. Search for **Framework Search Paths**
4. Double-click on the value
5. Add: `$(PROJECT_DIR)/Framworks`
6. Make sure it's set to **recursive**

### Step 4: Update Bridging Header

The `Runner-Bridging-Header.h` file should already import the framework:

```objc
#import <MTBeaconPlus/MTBeaconPlus.h>
```

If not, add this line to `ios/Runner/Runner-Bridging-Header.h`

### Step 5: Clean and Build

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

## Usage in Flutter

### 1. Import the Service

```dart
import 'package:luggage_tracking/services/beacon_plus_service.dart';
```

### 2. Initialize and Listen to Events

```dart
final beaconService = BeaconPlusService();

// Listen to events
beaconService.listenToEvents().listen((event) {
  switch (event.type) {
    case BeaconPlusEventType.scanResult:
      // Handle discovered devices
      final devices = event.devices?.map((d) => 
        BeaconPlusDevice.fromMap(Map<String, dynamic>.from(d))
      ).toList();
      print('Found ${devices?.length} devices');
      break;
      
    case BeaconPlusEventType.connected:
      print('Device connected: ${event.message}');
      break;
      
    case BeaconPlusEventType.rssiUpdate:
      print('RSSI: ${event.rssi}, Distance: ${event.distance}m');
      break;
      
    case BeaconPlusEventType.connectionError:
      print('Connection error: ${event.error}');
      break;
      
    default:
      print('Event: ${event.type}');
  }
});
```

### 3. Start Scanning

```dart
await beaconService.startScan();
```

### 4. Connect to Device

```dart
await beaconService.connectToDevice(
  macAddress: 'C3:00:00:5E:32:AF',
  password: 'minew123', // Optional, defaults to 'minew123'
);
```

### 5. Disconnect

```dart
await beaconService.disconnectDevice();
```

### 6. Stop Scanning

```dart
await beaconService.stopScan();
```

## Integration with Existing Controllers

### Update DeviceScreenController

```dart
// Add to DeviceScreenController
final beaconService = BeaconPlusService();
StreamSubscription? _beaconEventSubscription;

@override
void onInit() {
  super.onInit();
  
  // Only use BeaconPlus on iOS
  if (beaconService.isIOS) {
    _setupBeaconPlusListener();
  }
}

void _setupBeaconPlusListener() {
  _beaconEventSubscription = beaconService.listenToEvents().listen((event) {
    switch (event.type) {
      case BeaconPlusEventType.scanResult:
        // Update discovered devices
        break;
      case BeaconPlusEventType.rssiUpdate:
        currentRssi.value = event.rssi ?? 0;
        estimatedDistance.value = event.distance ?? 0.0;
        update();
        break;
      default:
        break;
    }
  });
}

Future<void> connectToDeviceByMacAddress(String macAddress, {required String deviceName}) async {
  if (beaconService.isIOS) {
    // Use BeaconPlus SDK on iOS
    await beaconService.connectToDevice(macAddress: macAddress);
  } else {
    // Use flutter_reactive_ble on Android
    // ... existing Android code ...
  }
}

@override
void onClose() {
  _beaconEventSubscription?.cancel();
  beaconService.dispose();
  super.onClose();
}
```

## Troubleshooting

### Framework Not Found Error

If you get "Framework not found MTBeaconPlus" error:

1. Check that frameworks are in `ios/Framworks/` folder
2. Verify Framework Search Paths in Build Settings
3. Clean build folder: Product → Clean Build Folder in Xcode
4. Delete DerivedData: `rm -rf ~/Library/Developer/Xcode/DerivedData`

### Bridging Header Error

If you get bridging header errors:

1. Make sure `Runner-Bridging-Header.h` exists
2. Check Build Settings → Swift Compiler → Objective-C Bridging Header
3. Should be set to: `Runner/Runner-Bridging-Header.h`

### Pod Install Issues

If pod install fails:

```bash
cd ios
rm -rf Pods Podfile.lock
pod deintegrate
pod install
```

## Features Supported

- ✅ Scan for Minew BeaconPlus devices
- ✅ Connect to devices
- ✅ Real-time RSSI monitoring
- ✅ Distance calculation
- ✅ Device information retrieval
- ✅ Password authentication
- ✅ Multiple frame types (iBeacon, UID, URL, etc.)
- ✅ Battery level monitoring

## Notes

- The BeaconPlus SDK only works on iOS
- On Android, the app will continue to use `flutter_reactive_ble`
- The service automatically detects the platform and uses the appropriate method
- RSSI updates occur every 1.5 seconds when connected
- Default password is `minew123` if not specified
