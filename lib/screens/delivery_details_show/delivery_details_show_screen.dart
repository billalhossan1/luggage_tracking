import 'package:flutter/material.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class DeliveryDetailsShowScreen extends StatelessWidget {
  const DeliveryDetailsShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "Delivery Info"));
  }
}
