import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/sub_plan_screen/model/subscription_plan_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:luggage_tracking/widgets/subscription_web_view/subscription_web_view.dart';

class SubPlanScreenController extends GetxController {
  RxString argEmail = ''.obs;
  RxString argName = ''.obs;
  RxString argToken = ''.obs;
  RxList<Plan> subscriptionPlanList = <Plan>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    argEmail.value = Get.arguments['email'] ?? '';
    argName.value = Get.arguments['name'] ?? '';
    argToken.value = Get.arguments['token'] ?? '';

    if (!Get.isRegistered<NetworkCaller>()) {
      Get.put(NetworkCaller(), permanent: true);
    }

    getSubscriptionPlan();
  }

  Future<NetworkResponse> apiCall() async {
    final networkCaller = Get.find<NetworkCaller>();
    return networkCaller.getRequest(
      Urls.getSubscriptionPlanListUrl,
      accessToken: argToken.value,
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () => throw Exception("Request timed out"),
    );
  }

  Future<void> getSubscriptionPlan() async {
    isLoading.value = true;
    try {
      final response = await apiCall();

      if (response.isSuccess) {
        Map<String, dynamic> responseMap;
        if (response.responseData is String) {
          responseMap = json.decode(response.responseData);
        } else if (response.responseData is Map<String, dynamic>) {
          responseMap = response.responseData;
        } else {
          throw Exception("Unexpected response format");
        }

        final planModel = SubscriptionPlanModel.fromJson(responseMap);
        if (planModel.plans != null && planModel.plans!.isNotEmpty) {
          subscriptionPlanList.value = planModel.plans!;
        } else {
          subscriptionPlanList.clear();
          AppSnackBar.error("No subscription plans available");
        }
      } else {
        subscriptionPlanList.clear();
        AppSnackBar.error(response.errorMessage);
      }
    } catch (e) {
      subscriptionPlanList.clear();
      AppSnackBar.error('Error fetching plans: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onTapSubscription(BuildContext context, {required String paymentUrl}) {
    openSubscriptionWebView(context, argEmail.value, paymentUrl,argToken.value);
  }
}
