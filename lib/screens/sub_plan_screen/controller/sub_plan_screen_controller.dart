import 'dart:convert';
import 'dart:io';

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

    Logger().i("Arguments received - Email: ${argEmail.value}, Token: ${argToken.value}");

    // Check if NetworkCaller is initialized
    if (!Get.isRegistered<NetworkCaller>()) {
      Logger().e("NetworkCaller is not registered!");
      Get.put(NetworkCaller(), permanent: true);
    }

    getSubscriptionPlan();
  }

  Future<dynamic> apiCall() async {
    try {
      final networkCaller = Get.find<NetworkCaller>();
      Logger().i("NetworkCaller found, making API call...");
      Logger().i("URL: ${Urls.getSubscriptionPlanListUrl}");
      Logger().i("Token: ${argToken.value}");

      // Add timeout to prevent hanging
      final NetworkResponse response = await networkCaller.getRequest(
          Urls.getSubscriptionPlanListUrl,
          accessToken: argToken.value
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          Logger().e("API call timed out after 30 seconds");
          throw Exception("Request timed out");
        },
      );

      Logger().i("API call completed with status: ${response.statusCode}");
      Logger().i("Response success: ${response.isSuccess}");

      return response;
    } catch (e) {
      Logger().e("Error in apiCall: $e");
      rethrow;
    }
  }

  Future<void> getSubscriptionPlan() async {
    try {
      isLoading.value = true;
      Logger().i("Starting to fetch subscription plans...");

      NetworkResponse response = await apiCall();
      Logger().i("Got response from API call");

      if (response.isSuccess) {
        Logger().i("API Response successful");
        Logger().i("Response data type: ${response.responseData.runtimeType}");
        Logger().i("Response data: ${response.responseData}");

        // Handle different response formats
        Map<String, dynamic> responseMap;

        if (response.responseData is String) {
          // If response is a string, try to decode it
          try {
            responseMap = json.decode(response.responseData);
            Logger().i("Decoded string response to Map");
          } catch (e) {
            Logger().e("Failed to decode string response: $e");
            throw Exception("Invalid JSON response");
          }
        } else if (response.responseData is Map<String, dynamic>) {
          responseMap = response.responseData;
        } else {
          Logger().e("Unexpected response type: ${response.responseData.runtimeType}");
          throw Exception("Unexpected response format");
        }

        Logger().i("Response map keys: ${responseMap.keys}");

        // Try to parse using your model
        try {
          SubscriptionPlanModel planModel = SubscriptionPlanModel.fromJson(responseMap);
          Logger().i("Model parsing successful");
          Logger().i("Plans count in model: ${planModel.plans?.length ?? 0}");

          if (planModel.plans != null && planModel.plans!.isNotEmpty) {
            subscriptionPlanList.value = planModel.plans!;
            Logger().i("Successfully loaded ${subscriptionPlanList.length} subscription plans");

            // Log first plan details for debugging
            if (subscriptionPlanList.isNotEmpty) {
              Logger().i("First plan: ${subscriptionPlanList.first.title}");
            }
          } else {
            subscriptionPlanList.clear();
            Logger().w("No subscription plans found in the model");

            // Check if plans exist in response but not parsed correctly
            if (responseMap.containsKey('plans')) {
              Logger().i("Plans key exists in response: ${responseMap['plans']}");
            }
            if (responseMap.containsKey('data')) {
              Logger().i("Data key exists in response: ${responseMap['data']}");
            }

            AppSnackBar.error("No subscription plans available");
          }
        } catch (e) {
          Logger().e("Error parsing model: $e");
          // Try manual parsing as fallback
          if (responseMap.containsKey('plans') && responseMap['plans'] is List) {
            List plansList = responseMap['plans'];
            Logger().i("Manual parsing - plans list length: ${plansList.length}");

            List<Plan> plans = [];
            for (var planData in plansList) {
              try {
                plans.add(Plan.fromJson(planData));
              } catch (e) {
                Logger().e("Error parsing individual plan: $e");
              }
            }

            if (plans.isNotEmpty) {
              subscriptionPlanList.value = plans;
              Logger().i("Manual parsing successful: ${plans.length} plans");
            }
          }

          if (subscriptionPlanList.isEmpty) {
            AppSnackBar.error("Failed to parse subscription plans");
          }
        }

      } else {
        subscriptionPlanList.clear();
        Logger().e("API Error - Status: ${response.statusCode}");
        Logger().e("Error message: ${response.errorMessage}");
        Logger().e("Response data: ${response.responseData}");
        AppSnackBar.error(response.errorMessage ?? 'Failed to fetch plans');
      }
    } catch (e) {
      subscriptionPlanList.clear();
      Logger().e("Exception in getSubscriptionPlan: $e");
      Logger().e("Stack trace: ${StackTrace.current}");
      AppSnackBar.error('An error occurred while fetching plans: $e');
    } finally {
      isLoading.value = false;
      Logger().i("Loading completed. Plans count: ${subscriptionPlanList.length}");
    }
  }

  void onTapSubscription(BuildContext context, {required String paymentUrl}) {
    openSubscriptionWebView(context, argEmail.value, paymentUrl);
  }
}