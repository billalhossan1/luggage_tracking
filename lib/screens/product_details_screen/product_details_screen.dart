import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/customer_event_info_screen/controller/customer_event_info_screen.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String category = Get.arguments;

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Products niceties"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: GetBuilder<CustomerEventInfoController>(
          init: CustomerEventInfoController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: AppSize.width(value: double.infinity),
                    height: AppSize.width(value: 300),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              controller.selectedImage,
                              width: AppSize.width(value: 189),
                              height: AppSize.width(value: 300),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.images.length,
                              itemBuilder: (context, index) {
                                final img = controller.images[index];
                                return GestureDetector(
                                  onTap: () => controller.selectImage(img),
                                  child: Container(
                                    padding: EdgeInsets.all(12),
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
                                        width: AppSize.width(value: 40),
                                        height: AppSize.width(value: 40),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Small image list
                  // SizedBox(
                  //   height: AppSize.width(value: 78),
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: controller.images.length,
                  //     itemBuilder: (context, index) {
                  //       final img = controller.images[index];
                  //       return GestureDetector(
                  //         onTap: () => controller.selectImage(img),
                  //         child: Container(
                  //           margin: EdgeInsets.only(
                  //             right: AppSize.width(value: 4),
                  //           ),
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color:
                  //                   controller.selectedImage == img
                  //                       ? Colors.blue
                  //                       : Colors.transparent,
                  //               width: 2,
                  //             ),
                  //             borderRadius: BorderRadius.circular(
                  //               AppSize.width(value: 8),
                  //             ),
                  //           ),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(
                  //               AppSize.width(value: 8),
                  //             ),
                  //             // child: AppImage(
                  //             //   url: img,
                  //             //   width: AppSize.width(value: 78),
                  //             //   height: AppSize.width(value: 78),
                  //             //   fit: BoxFit.cover,
                  //             // ),

                  //             child: Image.asset(
                  //               img,
                  //               width: AppSize.width(value: 78),
                  //               height: AppSize.width(value: 78),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
