import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/routes/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

void paymentWebView(BuildContext context, String paymentUrl) {
  final logger = Logger();
  String url = paymentUrl;
  logger.i("Opening subscription URL: $url");

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          // Handle success URL
          if (request.url.startsWith(Urls.paymentSuccessUrl)) {
            logger.i("Payment Success URL detected");
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Payment Successful'),
                content: const Text('Your subscription payment was successful.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.instance.navigationScreen);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return NavigationDecision.prevent;
          }
          // Handle cancel URL
          if (request.url.startsWith(Urls.paymentCancelUrl)) {
            logger.i("Payment Cancelled URL detected");
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Payment Failed'),
                content: const Text('Your subscription payment was Failed.'),
                actions: [
                  TextButton(
                    onPressed: () {
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
