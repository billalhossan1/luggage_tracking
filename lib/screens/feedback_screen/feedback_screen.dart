import 'package:flutter/material.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "FeedBack"),
    );
  }
}