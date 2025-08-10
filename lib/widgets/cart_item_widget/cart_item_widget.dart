import 'package:flutter/material.dart';
import '../../const/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/gap.dart';
import '../app_image/app_image.dart';

class CartItemWidget extends StatelessWidget {
  final String name;
  final String category;
  final String color;
  final String image;
  final num price;
  final int quantity;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement, required this.image, required this.category, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8),
      child: Container(
        color: Color(0xffFEFEFE),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppImage(
                  url: image,
                  height: AppSize.height(value: 90),
                  width: AppSize.width(value: 80),
                  fit: BoxFit.cover,
                ),
              ),

              const Gap(width: 12),

              // Product Info + Controls
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name, Variant & Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name & Variant
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,style: TextStyle(fontSize: 14),),
                            Text(category,style: TextStyle(fontSize: 14),),
                            Text("color: $color",style: TextStyle(fontSize: 14),),


                          ],
                        ),
                        // Delete Icon
                        Padding(
                            padding: const EdgeInsets.all(6.0),
                            child:GestureDetector(
                              onTap: (){
                                onDelete();
                              },
                              child: Container(
                                height: 34,
                                width: 34,

                                decoration: BoxDecoration(
                                  color: Color(0xffF5D9D7),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Color(0xffF5D9D7), width: 1.5),

                                ),

                                child: Center(child: Icon(Icons.delete_outline, color: AppColors.instance.red2, size: 20)),

                              ),
                            )
                        ),
                      ],
                    ),
                    const Gap(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$$price',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        IncreamentDecreamentButton(
                          quantity: quantity,
                          onIncrement: onIncrement,
                          onDecrement: onDecrement,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncreamentDecreamentButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const IncreamentDecreamentButton({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon:  Icon(Icons.remove_circle_outline,color: Color(0xff8F00FF),size: 25,),
          onPressed: onDecrement,

        ),
        Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: Icon(Icons.add_circle,color: Color(0xff8F00FF),size: 25,),
          onPressed: onIncrement,
        ),
      ],
    );
  }
}

