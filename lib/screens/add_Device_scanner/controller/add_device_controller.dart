import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddDeviceController extends GetxController{
  final TextEditingController itemNameController = TextEditingController();
  final MobileScannerController scannerController = MobileScannerController();
  bool termsAgreed = false;
  String? scannedDeviceId;



  @override
  void onClose() {
    itemNameController.dispose();
    scannerController.dispose();
    super.onClose();
  }
  final List<String> categories = [
    'Electronics',
    'Keys',
    'Wallet',
    'Bag',
    'Other',
  ];
}