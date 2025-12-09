// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:luggage_tracking/screens/add_Device_scanner/controller/add_device_controller.dart';
//
// /// Debug screen to show ALL discovered Bluetooth devices
// /// This helps troubleshoot why Minew devices might not be showing up
// class BluetoothDebugScreen extends StatelessWidget {
//   const BluetoothDebugScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AddDeviceController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bluetooth Debug'),
//         backgroundColor: Colors.purple,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help_outline),
//             onPressed: () {
//               _showHelpDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Instructions Banner
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: Colors.blue.shade50,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Colors.blue),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Debug Mode - Shows ALL Bluetooth Devices',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade900,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Look for your Minew device in the list below. If it appears here but not in the main list, note its name/MAC and report it.',
//                   style: TextStyle(fontSize: 12, color: Colors.blue.shade800),
//                 ),
//               ],
//             ),
//           ),
//
//           // Scan Control
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Obx(() => ElevatedButton.icon(
//                     onPressed: controller.isBluetoothScanning.value
//                         ? controller.stopBluetoothScan
//                         : controller.startBluetoothScan,
//                     icon: Icon(
//                       controller.isBluetoothScanning.value
//                           ? Icons.stop
//                           : Icons.search,
//                     ),
//                     label: Text(
//                       controller.isBluetoothScanning.value
//                           ? 'Stop Scanning'
//                           : 'Start Scanning',
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: controller.isBluetoothScanning.value
//                           ? Colors.red
//                           : Colors.purple,
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   )),
//                 ),
//                       ),
//                     );
//                   }
//
//                   if (devices.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.bluetooth_disabled, size: 64, color: Colors.grey),
//                           SizedBox(height: 16),
//                           Text('No devices found'),
//                           SizedBox(height: 8),
//                           Text(
//                             'Tap "Start Scanning" to search',
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: devices.length,
//                     itemBuilder: (context, index) {
//                       final device = devices[index];
//                       final isMinew = _isLikelyMinew(device.name, device.id);
//
//                       return Card(
//                         margin: EdgeInsets.only(bottom: 12),
//                         elevation: 2,
//                         color: isMinew ? Colors.green.shade50 : Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: isMinew ? Colors.green : Colors.grey.shade300,
//                             width: isMinew ? 2 : 1,
//                           ),
//                         ),
//                         child: ExpansionTile(
//                           leading: Icon(
//                             isMinew ? Icons.star : Icons.bluetooth,
//                             color: isMinew ? Colors.green : Colors.blue,
//                             size: 32,
//                           ),
//                           title: Text(
//                             device.name.isEmpty ? 'Unknown Device' : device.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: isMinew ? Colors.green.shade900 : Colors.black,
//                             ),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 4),
//                               Text(
//                                 'RSSI: ${device.rssi} dBm',
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                               if (isMinew)
//                                 Container(
//                                   margin: EdgeInsets.only(top: 4),
//                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Text(
//                                     '✓ Likely Minew Device',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildInfoRow('MAC Address', device.id, context),
//                                   SizedBox(height: 8),
//                                   _buildInfoRow('Device Name', device.name.isEmpty ? 'None' : device.name, context),
//                                   SizedBox(height: 8),
//                                   _buildInfoRow('RSSI', '${device.rssi} dBm', context),
//                                   SizedBox(height: 8),
//                                   _buildInfoRow(
//                                     'Estimated Distance',
//                                     '${controller.rssiToDistance(device.rssi).toStringAsFixed(2)} meters',
//                                     context,
//                                   ),
//                                   SizedBox(height: 8),
//                                   _buildInfoRow('Service UUIDs', '${device.serviceUuids.length} services', context),
//                                   if (device.serviceUuids.isNotEmpty) ...[
//                                     SizedBox(height: 4),
//                                     ...device.serviceUuids.map((uuid) => Padding(
//                                       padding: EdgeInsets.only(left: 16, top: 2),
//                                       child: Text(
//                                         '• $uuid',
//                                         style: TextStyle(fontSize: 10, color: Colors.grey),
//                                       ),
//                                     )),
//                                   ],
//                                   SizedBox(height: 16),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: ElevatedButton.icon(
//                                           onPressed: () {
//                                             controller.connectToBluetoothDevice(device.id);
//                                           },
//                                           icon: Icon(Icons.bluetooth_connected, size: 16),
//                                           label: Text('Connect'),
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.purple,
//                                             foregroundColor: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value, BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 140,
//           child: Text(
//             '$label:',
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//               color: Colors.grey[700],
//             ),
//           ),
//         ),
//         Expanded(
//           child: GestureDetector(
//             onLongPress: () {
//               Clipboard.setData(ClipboardData(text: value));
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Copied: $value'),
//                   duration: Duration(seconds: 1),
//                 ),
//               );
//             },
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   bool _isLikelyMinew(String name, String mac) {
//     String nameLower = name.toLowerCase();
//     String macUpper = mac.toUpperCase();
//
//     return nameLower.contains('minew') ||
//         nameLower.contains('e8') ||
//         nameLower.contains('d15') ||
//         macUpper.contains('2ABU6') ||
//         macUpper.startsWith('AC:23:3F') ||
//         macUpper.startsWith('A4:C1:38');
//   }
//
//   void _showHelpDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('How to Use Debug Mode'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '1. Tap "Start Scanning"',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text('2. Look for your Minew device in the list'),
//               SizedBox(height: 8),
//               Text('3. Devices marked with ★ are likely Minew devices'),
//               SizedBox(height: 8),
//               Text('4. Tap on a device to see detailed information'),
//               SizedBox(height: 8),
//               Text('5. Long-press on any value to copy it'),
//               SizedBox(height: 16),
//               Text(
//                 'Troubleshooting:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text('• If no devices appear, check Bluetooth is ON'),
//               SizedBox(height: 4),
//               Text('• Ensure location permission is granted'),
//               SizedBox(height: 4),
//               Text('• Make sure your Minew device is powered on'),
//               SizedBox(height: 4),
//               Text('• Try moving closer to the device'),
//               SizedBox(height: 4),
//               Text('• Check device battery level'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Got it'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
