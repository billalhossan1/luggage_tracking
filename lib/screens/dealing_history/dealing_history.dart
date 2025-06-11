import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/dealing_history/controller/dealing_history_screen_controller.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/cards/app_card/app_card.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class DealingHistoryScreen extends StatelessWidget {
  const DealingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DealingHistoryScreenController>(
      init: DealingHistoryScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Dealing History"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 16)),
            child: Obx(
                  () => Column(
                children: [
                  // Check if loading or empty
                  if (controller.isLoading.value)
                    const Center(child: CircularProgressIndicator())
                  else if (controller.dealingHistory.isEmpty)
                    const Center(child: Text('No dealing history available'))
                  else
                  // Display the dealing history data in a ListView
                    Expanded(
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.dealingHistory.length + 1, // Add 1 for the loading indicator
                        itemBuilder: (context, index) {
                          // If the index is the last item, check if we need to show the loading indicator
                          if (index == controller.dealingHistory.length) {
                            // If pagination is loading, show the circular indicator
                            if (controller.isPaginationLoading.value) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                ),
                              );
                            } else {
                              return SizedBox.shrink(); // Empty container when no loading
                            }
                          }

                          final order = controller.dealingHistory[index];

                          // Determine status color
                          Color statusColor;
                          String statusText = order.status ?? "Pending";

                          if (statusText == "Completed") {
                            statusColor = AppColors.instance.green1;
                          } else if (statusText == "Pending") {
                            statusColor = AppColors.instance.blue1;
                          } else {
                            statusColor = AppColors.instance.yellow1;
                          }

                          return AppCard(
                            child: Row(
                              children: [
                                // First column: Image
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: AppImage(
                                      url: Urls.imageBaseUrl + order.product!.images![0],
                                      width: AppSize.width(value: 72),
                                      height: AppSize.width(value: 72),
                                    ),
                                  ),
                                ),

                                // Second column: Order details
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    spacing: AppSize.width(value: 8),
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        data: "Order No: #${order.txid}",
                                        fontSize: AppSize.width(value: 14),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.instance.black200,
                                      ),
                                      AppText(
                                        data: order.product?.name ?? "Product Name",
                                        fontSize: AppSize.width(value: 14),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.instance.black400,
                                      ),
                                      Row(
                                        children: [
                                          AppText(
                                            data: "Qty ",
                                            fontSize: AppSize.width(value: 12),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.black200,
                                          ),
                                          AppText(
                                            data: "${order.quantity}",
                                            fontSize: AppSize.width(value: 12),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.blue1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppText(
                                            data: "Total Price ",
                                            fontSize: AppSize.width(value: 12),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.black200,
                                          ),
                                          AppText(
                                            data: ": \$${order.price}",
                                            fontSize: AppSize.width(value: 12),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.blue1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Third column: Status
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: AppSize.width(value: 72),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        AppText(
                                          data: statusText,
                                          fontSize: AppSize.width(value: 12),
                                          fontWeight: FontWeight.w400,
                                          color: statusColor, // Apply dynamic color here
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.width(value: 10),
                                            vertical: AppSize.width(value: 9),
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.instance.white500,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: AppText(
                                            data: "Buy Again",
                                            fontSize: AppSize.width(value: 13),
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.instance.purple_500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  // Pagination Loading Indicator
                  if (controller.isPaginationLoading.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: const Center(child: LinearProgressIndicator()),
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
