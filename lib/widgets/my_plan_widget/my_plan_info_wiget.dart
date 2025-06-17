import 'package:flutter/material.dart';
import '../../const/app_colors.dart';
import '../../utils/app_size.dart';
import '../texts/app_text.dart';


class MyPlanInfoCard extends StatelessWidget {
  final List<Map<String, String>> details;
  const MyPlanInfoCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double labelWidth = constraints.maxWidth > 600 ? 160 : 130;

        return Column(
          children: details.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> item = entry.value;

            // Check if it's the last item
            bool isLastItem = index == details.length - 1;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: labelWidth,
                    child: AppText(
                      data: item['label'] ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const AppText(
                    data: ': ',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: AppText(
                        data: item['value'] ?? '',
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.height(value: 16),
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.right,
                        color: isLastItem ? AppColors.instance.blue1 : Color(0xff686868),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
