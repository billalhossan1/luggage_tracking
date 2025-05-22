import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/utils/app_size.dart';
import 'package:luggage_tracking/widgets/app_drop_down/app_drop_down.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/button/app_button.dart';
import 'package:luggage_tracking/widgets/texts/custom_text_field.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddTrkilDeviceScreen extends StatefulWidget {
  const AddTrkilDeviceScreen({super.key});

  @override
  State<AddTrkilDeviceScreen> createState() => _AddTrkilDeviceScreenState();
}

class _AddTrkilDeviceScreenState extends State<AddTrkilDeviceScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final MobileScannerController _scannerController = MobileScannerController();
  // String? _selectedCategory;
  bool _termsAgreed = false;
  String? _scannedDeviceId;

  final List<String> _categories = [
    'Electronics',
    'Keys',
    'Wallet',
    'Bag',
    'Other',
  ];

  @override
  void dispose() {
    _itemNameController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Trkil Device"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QR Scanner Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: .1),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomPaint(
                        painter: CornerBorderPainter(),
                        child: Container(
                          padding: EdgeInsets.all(AppSize.width(value: 4)),
                          height: AppSize.width(value: 300),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(0),
                            child:
                                _scannedDeviceId != null
                                    ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Device ID: $_scannedDeviceId',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    : Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        MobileScanner(
                                          controller: _scannerController,
                                          onDetect: (capture) {
                                            final List<Barcode> barcodes =
                                                capture.barcodes;
                                            for (final barcode in barcodes) {
                                              if (barcode.rawValue != null) {
                                                setState(() {
                                                  _scannedDeviceId =
                                                      barcode.rawValue;
                                                });
                                                break;
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                      ),
                      // child: Container(
                      //   height: 300,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(16),
                      //     border: Border.all(
                      //       color: Colors.purple.shade200,
                      //       width: 2,
                      //     ),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(16),
                      //     child:
                      //         _scannedDeviceId != null
                      //             ? Center(
                      //               child: Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(16),
                      //                     decoration: const BoxDecoration(
                      //                       color: Colors.black54,
                      //                       shape: BoxShape.circle,
                      //                     ),
                      //                     child: const Icon(
                      //                       Icons.check,
                      //                       color: Colors.white,
                      //                       size: 40,
                      //                     ),
                      //                   ),
                      //                   const SizedBox(height: 16),
                      //                   Text(
                      //                     'Device ID: $_scannedDeviceId',
                      //                     style: const TextStyle(
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             )
                      //             : Stack(
                      //               alignment: Alignment.center,
                      //               children: [
                      //                 MobileScanner(
                      //                   controller: _scannerController,
                      //                   onDetect: (capture) {
                      //                     final List<Barcode> barcodes =
                      //                         capture.barcodes;
                      //                     for (final barcode in barcodes) {
                      //                       if (barcode.rawValue != null) {
                      //                         setState(() {
                      //                           _scannedDeviceId =
                      //                               barcode.rawValue;
                      //                         });
                      //                         break;
                      //                       }
                      //                     }
                      //                   },
                      //                 ),

                      //               ],
                      //             ),
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Trkil Tracking device',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'D. ID: ${_scannedDeviceId ?? '1313646321321'}',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {
                                  setState(() {
                                    _scannedDeviceId = null;
                                  });
                                  _scannerController.start();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Item Name Field
              CustomTextField.build(hintText: "Item Name"),

              const SizedBox(height: 24),

              // Category Dropdown
              AppDropDown(hintText: "Category", items: _categories),

              const SizedBox(height: 24),

              // Terms of Service
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _termsAgreed,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAgreed = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                      activeColor: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'I agree with ',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to terms of service
                    },
                    child: const Text(
                      'terms of service',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text(' and ', style: TextStyle(color: Colors.grey.shade600)),
                  GestureDetector(
                    onTap: () {
                      // Navigate to privacy policy
                    },
                    child: const Text(
                      'privacy policy',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Connect Button
              AppButton(title: "Connect Device"),
            ],
          ),
        ),
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.instance.purple_100
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke;

    double length = 80;

    // Top-left
    canvas.drawLine(Offset(-2, 0), Offset(length, 0), paint);
    canvas.drawLine(Offset(0, -2), Offset(0, length), paint);

    // Top-right
    canvas.drawLine(
      Offset(size.width + 2, 0), // extend slightly outward
      Offset(size.width - length, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, -2), // move up slightly
      Offset(size.width, length),
      paint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(-2, size.height), // move left slightly
      Offset(length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height + 2), // move down slightly
      Offset(0, size.height - length),
      paint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width + 2, size.height), // move right slightly
      Offset(size.width - length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height + 2), // move down slightly
      Offset(size.width, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
