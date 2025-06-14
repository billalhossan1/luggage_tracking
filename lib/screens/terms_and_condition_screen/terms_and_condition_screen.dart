import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/controller/terms_and_condition_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsAndConditionController>(
      builder: (controller) {
        return Obx(()=>Scaffold(
          appBar: CustomAppBar(title: "Terms & Condition"),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
                      child: HtmlWidget(controller.termsAndConditionTextHtml)
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
