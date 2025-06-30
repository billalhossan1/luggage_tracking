import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          appBar: AppBar(title: Text('My Plan'),centerTitle: true,),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child:  controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : controller.myPlan?.plan?.title == null
                    ? Column(
                  children: [

                    Spacer(),
                    Center(child: Text("Now Your are using Free Plan",style: TextStyle(fontSize: 20,),)),
                    Spacer(),

                  ],
                )
                    :Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: MyPlanInfoCard(
                        details: controller.details,
                      ),
                    ),
                  ],
                ),
              ),
            ),

        );
      },
    );
  }
}
