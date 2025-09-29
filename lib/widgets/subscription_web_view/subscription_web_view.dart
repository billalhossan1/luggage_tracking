import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/save_data/save_data.dart';

void openSubscriptionWebView(BuildContext context, String email, String paymentUrl, String token) {
  final logger = Logger();
  String url = '$paymentUrl?prefilled_email=$email';
  logger.i("Opening subscription URL: $url");

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://dokterforyou.com/success')) {
            logger.i("Payment Success URL detected");
            Get.back();

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Payment Successful'),
                content: const Text('Your membership payment was successful.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.lazyPut(() => SaveDataController());
                      Get.find<SaveDataController>().saveUserData(token);

                      Navigator.of(context).pop();
                      Get.offAllNamed(AppRoutes.instance.navigationScreen);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(url));

  Get.dialog(
    Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: WebViewWidget(controller: controller),
    ),
    barrierDismissible: false,
  );
}

