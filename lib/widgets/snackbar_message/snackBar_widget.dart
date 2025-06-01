import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({
  required String title,
  required String message,
  bool isError = false,
}) {
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    ),
  );
}
