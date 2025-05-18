import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/customer_event_info_screen/controller/customer_event_info_screen.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/utils/gap.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
class CustomerEventInfoScreen extends StatelessWidget {
  // final String category = Get.arguments;

  const CustomerEventInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Event Information"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: GetBuilder<CustomerEventInfoController>(
          init: CustomerEventInfoController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Big image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 12),
                    ),
                    // child: AppImage(
                    //   url: controller.selectedImage,
                    //   width: double.infinity,
                    //   height: AppSize.width(value: 220),
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.asset(
                      controller.selectedImage,
                      width: double.infinity,
                      height: AppSize.width(value: 220),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(height: AppSize.width(value: 12)),
                  // Small image list
                  SizedBox(
                    height: AppSize.width(value: 78),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.images.length,
                      itemBuilder: (context, index) {
                        final img = controller.images[index];
                        return GestureDetector(
                          onTap: () => controller.selectImage(img),
                          child: Container(
                            margin: EdgeInsets.only(
                              right: AppSize.width(value: 4),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    controller.selectedImage == img
                                        ? Colors.blue
                                        : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSize.width(value: 8),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppSize.width(value: 8),
                              ),
                              // child: AppImage(
                              //   url: img,
                              //   width: AppSize.width(value: 78),
                              //   height: AppSize.width(value: 78),
                              //   fit: BoxFit.cover,
                              // ),

                              child: Image.asset(
                                img,
                                width: AppSize.width(value: 78),
                                height: AppSize.width(value: 78),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
