import 'package:flutter/material.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "Device"));
  }
}
