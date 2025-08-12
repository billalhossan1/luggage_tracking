import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class SubscriptionRequiredScreen extends StatelessWidget {
  const SubscriptionRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Subscription Required"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 80,
              color: Colors.amber[700],
            ),
            const SizedBox(height: 24),
            const Text(
              "Unlock This Feature",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "You need to purchase a subscription to access this premium feature. Upgrade now to enjoy all benefits.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (!Get.isRegistered<SaveDataController>()) {
                    Get.lazyPut(() => SaveDataController());
                  }
                  SaveDataController saveDataController = Get.find<SaveDataController>();

                  String email = await saveDataController.getUserEmail() ?? "";
                  String name = await saveDataController.getUserName() ?? "";
                  String token = await saveDataController.getUserData() ?? "";

                  Get.toNamed(
                    AppRoutes.instance.subPlanScreen,
                    arguments: {'email': email, 'name': name, 'token': token, 'from': 'home'},
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Purchase Subscription",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Maybe navigate back or show more info
              },
              child: const Text("Learn More"),
            )
          ],
        ),
      ),
    );
  }
}
