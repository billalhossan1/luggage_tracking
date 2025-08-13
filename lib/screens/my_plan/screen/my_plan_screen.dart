import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import '../../../widgets/my_plan_widget/my_plan_info_wiget.dart';
import '../controller/my_plan_controller.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPlanController>(
      init: MyPlanController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Plan'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : controller.myPlan?.plan?.title == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Now Your are using Free Plan",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Gap(height: 30),
                              AppButton(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.instance.subPlanScreen, );
                                  controller.onTapChangePlan();
                                },
                                title: "Purchase New Plan",
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: MyPlanInfoCard(
                                details: controller.details,
                              ),
                            ),
                            Gap(
                              height: 10,
                            ),
                            Obx(
                              () => AppButton(
                                isLoading: controller.cancelIsLoading.value,
                                title: "Cancel Subscription",
                                onTap: () {
                                  controller.onTapCancel();
                                },
                                filColor: Color(0xff8E00FE),
                              ),
                            ),
                            Gap(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AppButton(
                                title: 'Change Plan',
                                onTap: () {
                                  controller.onTapChangePlan();
                                },
                                filColor: Colors.white,
                                titleColor: Color(0xff8F00FF),
                                decoration: BoxDecoration(border: Border.all(color: Color(0xff8F00FF), width: 2)),
                              ),
                            )
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}
