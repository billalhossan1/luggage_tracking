import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../widgets/app_snack_bar/app_snack_bar.dart';
import '../widgets/texts/app_text.dart';
import 'app_all_log/error_log.dart';

Future<Position?> appUserGeoLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppSnackBar.error("Your device has no GPS services");
      return null;
    }
    permission = await Geolocator.checkPermission();
    Logger().i("message");
    Logger().i("permission: $permission");
    if (permission == LocationPermission.deniedForever) {

      await Future.delayed(const Duration(milliseconds: 500));
      bool wantsToEnable = await getCallAgainPermission();
      if (wantsToEnable) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
          return await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.bestForNavigation));
        }
      }
      return null;
    }

    if (permission == LocationPermission.denied) {

      var response = await firstAskPermission();
      if (!response) {
        return null;
      }
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        return null;
      }
    }

    Logger().i("About to get current position...");

    // Add timeout to prevent hanging
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: _locationSettings()
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        Logger().e("Location request timed out");
        throw Exception("Location request timed out");
      },
    );

    Logger().i("Successfully got position: ${position.latitude}, ${position.longitude}");
    return position;
  } catch (e) {
    Logger().e("Error in appUserGeoLocation: $e");
    errorLog("appUserGeoLocation", e);
    return null;
  }
}

LocationSettings _locationSettings() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    Logger().i("Platform: $defaultTargetPlatform");

    return AndroidSettings(
      accuracy: LocationAccuracy.medium, // Changed from high to medium
      distanceFilter: 100,
      forceLocationManager: false, // Changed from true to false
      intervalDuration: const Duration(seconds: 30), // Increased from 10 to 30 seconds
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText: "Trkli will continue to receive your location even when you're using it",
        notificationTitle: "Location Service",
        enableWakeLock: true,
      ),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
    return AppleSettings(
      accuracy: LocationAccuracy.high,
      activityType: ActivityType.fitness,
      distanceFilter: 100,
      pauseLocationUpdatesAutomatically: true,
      showBackgroundLocationIndicator: false,
    );
  } else if (kIsWeb) {
    return WebSettings(accuracy: LocationAccuracy.high, distanceFilter: 100, maximumAge: const Duration(minutes: 5));
  } else {
    return const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
  }
}

Future<bool> getCallAgainPermission({
  String title = "Location Access Needed",
  String content =
  """We use your location to show you nearby artists and services based on your preferences.\n\nThis helps us provide faster, more relevant service matches in your area. We only use your location when necessary and always respect your privacy.\n\nYou can enable location access in your device settings if you'd like to use this feature.""",
}) async {
  bool userConfirmed = false;

  await Get.defaultDialog(
    title: title,
    content: AppText(data: content, textAlign: TextAlign.center),
    radius: 8,
    confirm: ElevatedButton(
      onPressed: () async {
        userConfirmed = true;
        Get.back();
      },
      child: const AppText(data: "Open Settings"),
    ),
    cancel: TextButton(
      onPressed: () {
        userConfirmed = false;
        Get.back();
      },
      child: const AppText(data: "Cancel"),
    ),
  );

  if (userConfirmed) {
    await Geolocator.openAppSettings();
  }

  return userConfirmed;
}

Future<bool> firstAskPermission({
  String title = "Permission Required",
  String content = """
To provide secure and reliable tracking of your device, this app requires access to your location.

We use your location solely to help you monitor and recover your luggage or device in real time. Your location data is never shared with third parties and is only used for tracking purposes within this app.

Granting this permission is essential for the app's core functionality. You can manage or revoke this permission at any time in your device settings.
""",
}) async {
  bool userConfirmed = false;

  await Get.defaultDialog(
    title: title,
    content: AppText(data: content, textAlign: TextAlign.center),
    radius: 8,
    confirm: ElevatedButton(
      onPressed: () async {
        userConfirmed = true;
        Get.back();
      },
      child: const AppText(data: "Continue"),
    ),
  );
  return userConfirmed;
}