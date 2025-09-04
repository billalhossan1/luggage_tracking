import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> customCameraPermissionDialog() async {
  bool isApprove = false;
  try {
    var status = await Permission.camera.status;
    if (status.isGranted || status.isLimited) {
      return true;
    }
    if (status.isDenied) {
      var response = await askFirst();

      if (response) {
        final request = await Permission.camera.request();
        print("${request.isDenied} ${request.isGranted} ${request.isProvisional} ${request.isRestricted}");
        if (request.isGranted || request.isLimited) {
          return true;
        }
      }
    }
    if (status.isPermanentlyDenied) {
      var response = await getCallAgainPermission(
        acceptButton: "",
      );
      if (response) {
        final request = await Permission.camera.request();
        if (request.isGranted || request.isLimited) {
          return true;
        }
      }
    }
  } catch (e) {
    errorLog("cameraPermissionDialog", e);
  }
  return isApprove;
}

Future<bool> askFirst({
  String title = "Gallery",
  String content =
      "We need access to your camera so you can take or update your profile picture or Search Trkli Devices. We respect your privacy and only use the camera when you choose to use this feature.\nYou can enable camera access in your device settings.",
  String acceptButton = "Continue",
}) async {
  bool userConfirmed = false;

  await Get.defaultDialog(
      title: title,
      content: AppText(data: content, textAlign: TextAlign.center),
      radius: 8,
      confirm: ElevatedButton(
        onPressed: () async {
          userConfirmed = true;
          Navigator.pop(Get.context!);
        },
        child: AppText(data: acceptButton),
      ));
  return userConfirmed;
}

Future<bool> getCallAgainPermission({
  String title = "Camera Access Needed",
  String content = "This permission is required to continue. Please enable it from settings.",
  String acceptButton = "Open Settings",
  String cancelButton = "Cancel",
}) async {
  bool userConfirmed = false;

  await Get.defaultDialog(
    title: title,
    content: Text(content, textAlign: TextAlign.center),
    radius: 8,
    confirm: ElevatedButton(
      onPressed: () async {
        userConfirmed = true;
        Navigator.pop(Get.context!);
      },
      child: AppText(data: acceptButton),
    ),
    cancel: TextButton(
      onPressed: () {
        userConfirmed = false;
        Navigator.pop(Get.context!);
      },
      child: AppText(data: cancelButton),
    ),
  );
  print("object");

  if (userConfirmed) {
    await openAppSettings();
  }

  return userConfirmed;
}
