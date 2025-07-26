import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/work_func_screen/controller/work_func_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class WorkFuncScreen extends StatelessWidget {
  const WorkFuncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkFuncController>(
      builder: (controller) {
        return Obx(()=>Scaffold(
          appBar: CustomAppBar(title: "Work Functionality"),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
                      child: HtmlWidget(controller.workFunTextHtml)
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    );
  }
}
