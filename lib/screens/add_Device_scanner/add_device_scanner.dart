import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/bluetooth_debug_screen.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/widgets/bluetooth_device_status_card.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/widgets/bluetooth_devices_list.dart';
import 'package:luggage_tracking/screens/add_Device_scanner/widgets/bluetooth_status_widgets.dart';
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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDeviceController>(
      init: AddDeviceController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: "Add Trkil Device"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Connection Method Selector
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() => _buildMethodButton(
                            context,
                            icon: Icons.qr_code_scanner,
                            label: "QR Code",
                            isSelected: controller.connectionMethod.value == 'qr',
                            onTap: () => controller.setConnectionMethod('qr'),
                          )),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Obx(() => _buildMethodButton(
                            context,
                            icon: Icons.bluetooth,
                            label: "Bluetooth",
                            isSelected: controller.connectionMethod.value == 'bluetooth',
                            onTap: () => controller.setConnectionMethod('bluetooth'),
                          )),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // QR Scanner or Bluetooth Scanner Section
                  Obx(() => controller.connectionMethod.value == 'qr'
                      ? _buildQRScannerSection(controller)
                      : _buildBluetoothSection(controller)),

                  const SizedBox(height: 24),

                  // Item Name Field
                  CustomTextField.build(
                    controller: controller.itemNameController,
                    hintText: "Item Name",
                  ),

                  const SizedBox(height: 24),

                  // Category Dropdown
                  Obx(
                        () => AppDropDown(
                      hintText: "Category",
                      items: controller.categories,
                      selectedValue: controller.selectedCatName.value,
                      onChanged: (value) {
                        controller.selectedCatName.value = value;
                        controller.selectedCatId.value =
                            controller.getCatIdFromName(controller.selectedCatName.value);
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Terms of Service
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: controller.termsAgreed,
                            onChanged: (bool? value) {
                              setState(() {
                                controller.termsAgreed = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                            activeColor: Colors.purple,
                          ),
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
                      Text(
                        ' and ',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
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
                  Obx(
                        () => AppButton(
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        controller.onTapConnectDevice();
                      },
                      title: "Connect Device",
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

  Widget _buildMethodButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.instance.purple_100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.instance.purple_100 : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 28,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRScannerSection(AddDeviceController controller) {
    return Container(
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
                  child: controller.scannedDeviceId != null
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          'Device ID: ${controller.scannedDeviceId}',
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
                      GetBuilder<AddDeviceController>(
                        builder: (controller) {
                          return Obx(() {
                            if (!controller.isCameraPermissionGranted.value) {
                              return Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    controller.requestCameraPermission();
                                  },
                                  child: const Text('Tap to enable camera'),
                                ),
                              );
                            } else {
                              return MobileScanner(
                                controller: controller.scannerController,
                                onDetect: (capture) {
                                  final List<Barcode> barcodes = capture.barcodes;
                                  for (final barcode in barcodes) {
                                    if (barcode.rawValue != null) {
                                      setState(() {
                                        controller.scannedDeviceId = barcode.rawValue;
                                      });
                                      break;
                                    }
                                  }
                                },
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                  'Trkli Tracking device',
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
                      'D. ID: ${controller.scannedDeviceId ?? 'Not scanned'}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          controller.scannedDeviceId = null;
                          controller.isCameraPermissionGranted.value = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBluetoothSection(AddDeviceController controller) {
    return Container(
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
          // Bluetooth Control Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bluetooth Devices',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 12),
                        // Add connection status indicator
                        Obx(() {
                          if (controller.isBluetoothConnected.value) {
                            return ConnectionStatusIndicator();
                          }
                          return SizedBox.shrink();
                        }),
                      ],
                    ),
                    Obx(() => ElevatedButton.icon(
                      onPressed: controller.isBluetoothScanning.value
                          ? controller.stopBluetoothScan
                          : controller.startBluetoothScan,
                      icon: Icon(
                        controller.isBluetoothScanning.value
                            ? Icons.stop
                            : Icons.search,
                        size: 18,
                      ),
                      label: Text(
                        controller.isBluetoothScanning.value ? 'Stop' : 'Scan',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isBluetoothScanning.value
                            ? Colors.red
                            : AppColors.instance.purple_100,
                        foregroundColor: Colors.white,
                      ),
                    )),
                  ],
                ),

                // Debug Mode Button (helps troubleshoot device detection)
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.to(() => const BluetoothDebugScreen());
                        },
                        icon: Icon(Icons.bug_report, size: 16),
                        label: Text(
                          'Debug Mode - Show All Devices',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          side: BorderSide(color: Colors.orange),
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Enhanced Connected Device Info Card
          BluetoothDeviceStatusCard(),

          // Scanning Indicator
          Obx(() {
            if (controller.isBluetoothScanning.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Scanning for Minew devices...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          }),

          // Enhanced Device List
          Obx(() {
            final devices = controller.discoveredDevices;
            if (devices.isEmpty && !controller.isBluetoothScanning.value) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(Icons.bluetooth_disabled, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No devices found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Make sure your Minew device is powered on',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (devices.isNotEmpty) {
              return Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    final isConnected = controller.connectedBleDevice.value?.id == device.id;
                    final distance = controller.rssiToDistance(device.rssi);

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      elevation: isConnected ? 3 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isConnected ? Colors.green : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isConnected
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
                            color: isConnected ? Colors.green : Colors.blue,
                            size: 28,
                          ),
                        ),
                        title: Text(
                          device.name.isNotEmpty ? device.name : 'Unknown Device',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              'MAC: ${device.id}',
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.signal_cellular_alt, size: 12, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  '${device.rssi} dBm',
                                  style: TextStyle(fontSize: 11),
                                ),
                                SizedBox(width: 12),
                                Icon(Icons.straighten, size: 12, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  '~${distance.toStringAsFixed(1)}m',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            if (isConnected) ...[
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: DistanceDisplay(showCategory: true),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        trailing: isConnected
                          ? IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: controller.disconnectBluetoothDevice,
                            )
                          : ElevatedButton(
                              onPressed: controller.isBluetoothConnected.value
                                ? null
                                : () => controller.connectToBluetoothDevice(device.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.instance.purple_100,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Connect', style: TextStyle(fontSize: 12)),
                            ),
                      ),
                    );
                  },
                ),
              );
            }

            return SizedBox.shrink();
          }),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.instance.purple_100
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double length = 80;

    // Top-left
    canvas.drawLine(Offset(-2, 0), Offset(length, 0), paint);
    canvas.drawLine(Offset(0, -2), Offset(0, length), paint);

    // Top-right
    canvas.drawLine(
      Offset(size.width + 2, 0),
      Offset(size.width - length, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, -2),
      Offset(size.width, length),
      paint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(-2, size.height),
      Offset(length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height + 2),
      Offset(0, size.height - length),
      paint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width + 2, size.height),
      Offset(size.width - length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height + 2),
      Offset(size.width, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luggage_tracking/const/app_colors.dart';
// import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';
// import 'package:luggage_tracking/utils/app_size.dart';
// import 'package:luggage_tracking/widgets/app_drop_down/app_drop_down.dart';
// import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
// import 'package:luggage_tracking/widgets/button/app_button.dart';
// import 'package:luggage_tracking/widgets/texts/custom_text_field.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class AddTrkilDeviceScreen extends StatefulWidget {
//   const AddTrkilDeviceScreen({super.key});
//
//   @override
//   State<AddTrkilDeviceScreen> createState() => _AddTrkilDeviceScreenState();
// }
//
// class _AddTrkilDeviceScreenState extends State<AddTrkilDeviceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AddDeviceController>(
//       init: AddDeviceController(),
//       builder: (controller) {
//         return Scaffold(
//           appBar: CustomAppBar(title: "Add Trkil Device"),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // QR Scanner Section
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withValues(alpha: .1),
//                           blurRadius: 8,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: CustomPaint(
//                             painter: CornerBorderPainter(),
//                             child: Container(
//                               padding: EdgeInsets.all(AppSize.width(value: 4)),
//                               height: AppSize.width(value: 300),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: ClipRRect(
//                                 // borderRadius: BorderRadius.circular(0),
//                                 child: controller.scannedDeviceId != null
//                                     ? Center(
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(
//                                                 16,
//                                               ),
//                                               decoration: const BoxDecoration(
//                                                 color: Colors.black54,
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: const Icon(
//                                                 Icons.check,
//                                                 color: Colors.white,
//                                                 size: 40,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 16),
//                                             Text(
//                                               'Device ID: ${controller.scannedDeviceId}',
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           GetBuilder<AddDeviceController>(builder: (controller) {
//                                             return Obx(() {
//                                               if (!controller.isCameraPermissionGranted.value) {
//                                                 return Center(
//                                                   child: ElevatedButton(
//                                                     onPressed: () async {
//                                                       controller.requestCameraPermission();
//                                                     },
//                                                     child: const Text('Tap to enable camera'),
//                                                   ),
//                                                 );
//                                               } else {
//                                                 return MobileScanner(
//                                                   controller: controller.scannerController,
//                                                   onDetect: (capture) {
//                                                     final List<Barcode> barcodes = capture.barcodes;
//                                                     for (final barcode in barcodes) {
//                                                       if (barcode.rawValue != null) {
//                                                         setState(() {
//                                                           controller.scannedDeviceId = barcode.rawValue;
//                                                         });
//                                                         break;
//                                                       }
//                                                     }
//                                                   },
//                                                 );
//                                               }
//                                             });
//                                           }),
//                                         ],
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 12,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Trkli Tracking device',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'D. ID: ${controller.scannedDeviceId ?? '1313646321321'}',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade700,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.refresh),
//                                     onPressed: () {
//                                       setState(() {
//                                         controller.scannedDeviceId = null;
//                                         controller.isCameraPermissionGranted.value = false;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // Item Name Field
//                   CustomTextField.build(controller: controller.itemNameController, hintText: "Item Name"),
//
//                   const SizedBox(height: 24),
//
//                   Obx(
//                     () => AppDropDown(
//                       hintText: "Category",
//                       items: controller.categories,
//                       selectedValue: controller.selectedCatName.value,
//                       onChanged: (value) {
//                         controller.selectedCatName.value = value;
//                         controller.selectedCatId.value = controller.getCatIdFromName(controller.selectedCatName.value);
//                       },
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // Terms of Service
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: Checkbox(
//                             value: controller.termsAgreed,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 controller.termsAgreed = value ?? false;
//                               });
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             side: BorderSide(color: Colors.grey.shade400),
//                             activeColor: Colors.purple,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'I agree with ',
//                         style: TextStyle(color: Colors.grey.shade600),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           // Navigate to terms of service
//                         },
//                         child: const Text(
//                           'terms of service',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                       Text(
//                         ' and ',
//                         style: TextStyle(color: Colors.grey.shade600),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           // Navigate to privacy policy
//                         },
//                         child: const Text(
//                           'privacy policy',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 32),
//
//                   // Connect Button
//                   Obx(
//                     () => AppButton(
//                         isLoading: controller.isLoading.value,
//                         onTap: () {
//                           controller.onTapConnectDevice();
//                         },
//                         title: "Connect Device"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CornerBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.instance.purple_100
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke;
//
//     double length = 80;
//
//     // Top-left
//     canvas.drawLine(Offset(-2, 0), Offset(length, 0), paint);
//     canvas.drawLine(Offset(0, -2), Offset(0, length), paint);
//
//     // Top-right
//     canvas.drawLine(
//       Offset(size.width + 2, 0), // extend slightly outward
//       Offset(size.width - length, 0),
//       paint,
//     );
//     canvas.drawLine(
//       Offset(size.width, -2), // move up slightly
//       Offset(size.width, length),
//       paint,
//     );
//
//     // Bottom-left
//     canvas.drawLine(
//       Offset(-2, size.height), // move left slightly
//       Offset(length, size.height),
//       paint,
//     );
//     canvas.drawLine(
//       Offset(0, size.height + 2), // move down slightly
//       Offset(0, size.height - length),
//       paint,
//     );
//
//     // Bottom-right
//     canvas.drawLine(
//       Offset(size.width + 2, size.height), // move right slightly
//       Offset(size.width - length, size.height),
//       paint,
//     );
//     canvas.drawLine(
//       Offset(size.width, size.height + 2), // move down slightly
//       Offset(size.width, size.height - length),
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
