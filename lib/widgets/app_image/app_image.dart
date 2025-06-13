import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/utils/app_all_log/app_log.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.color = Colors.blue,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.iconColor,
  });
  // >>>>>>>>>>>>>>>>>>>>>> parameter accept this data  <<<<<<<<<<<<<<<<<<<<<<
  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit? fit;
  final double? width; // >>>>>>>>>>>>>>>>>>>>>> width and height provide by default size when parameter not provide <<<<<<<<<<<<<<<<<<<<<<
  final double? height;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {

    // >>>>>>>>>>>>>>>>>>>>>> file image is first <<<<<<<<<<<<<<<<<<<<<<
    if (filePath != null) {
      return Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          errorLog("error form file image :", error);
          return SizedBox(
            width: width,
            height: height,
            // color: AppColors.primary,
          );
        },
      );
    }

    // >>>>>>>>>>>>>>>>>>>>>> second network image  <<<<<<<<<<<<<<<<<<<<<<
    if (url != null) {
      if (url.toString().toLowerCase().contains("null")) {
        return Container(
          width: width,
          height: height,
          color: color,
        );
      }
      appLog("url");
      return NetworkImageWithRetry(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // >>>>>>>>>>>>>>>>>>>>>> thread local image or assets <<<<<<<<<<<<<<<<<<<<<<
    if (path != null) {
      return Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        color: iconColor,
        // >>>>>>>>>>>>>>>>>>>>>> when load fail image  <<<<<<<<<<<<<<<<<<<<<<
        errorBuilder: (context, error, stackTrace) {
          errorLog("asset image", error);
          return SizedBox(
            width: width,
            height: height,
            // color: AppColors.primary,
          );
        },
      );
    }
    // >>>>>>>>>>>>>>>>>>>>>>by default widget return  <<<<<<<<<<<<<<<<<<<<<<
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class NetworkImageWithRetry extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const NetworkImageWithRetry({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
  });

  @override
  State createState() => _NetworkImageWithRetryState();
}

class _NetworkImageWithRetryState extends State<NetworkImageWithRetry> {
  int _retryCount = 0;
  final int _maxRetries = 6;
  late String _image;

  @override
  void didUpdateWidget(covariant NetworkImageWithRetry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl.hashCode != widget.key.hashCode) {
      _retryCount = 0;
      _setImage();
      WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
          setState(() {});
        },
      );
    }
  }
  @override
  void initState() {
    super.initState();
    _setImage();

  }


  void _setImage() {
    try {
      final uri = Uri.tryParse(widget.imageUrl);
      if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
        _image = widget.imageUrl;
      } else if (widget.imageUrl.runtimeType == Null) {
        _image = "";
      } else {
        _image = "${Urls.imageBaseUrl}${widget.imageUrl}";
      }
    } catch (e) {
      _image = widget.imageUrl;
      errorLog("set image private function", e);
    }
  }

  // Retry function in case of failure
  void _retry() async {
    try {
      if (_retryCount < _maxRetries) {
        await Future.delayed(const Duration(seconds: 2), () {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              if (mounted) {
                setState(() {
                  _retryCount++;
                });
              }
            },
          );
        });
      }
    } catch (e) {
      errorLog("error form network image retry function ", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = CustomHttpClient();
    return Image.network(
      _image,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        errorLog("Error loading network image:", stackTrace);
        appLog("image url : ${widget.imageUrl}");

        _retry();
        return Container(
          width: widget.width,
          height: widget.height,
          color: AppColors.instance.white100,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: widget.width,
          height: widget.height,
          color: AppColors.instance.white100,
        );
      },
    );
  }
}
