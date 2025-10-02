import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/utils/app_all_log/app_log.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';

class AppImageCircular extends StatelessWidget {
  const AppImageCircular({
    super.key,
    this.color = Colors.blue,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.borderRadius = 100,
  });
  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (filePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.file(
          File(filePath!),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                width: width,
                height: height,
                color: color,
              ),
            );
          },
        ),
      );
    }
    if (path != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              // color: AppColors.circleItemBorder,
              ),
          child: Image.asset(
            path!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: SizedBox(
                  width: width,
                  height: height,
                  // color: AppColors.primary,
                ),
              );
            },
          ),
        ),
      );
    }

    if (url != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: NetworkImageWithRetry(
          imageUrl: url!,
          borderRadius: borderRadius,
          fit: fit,
          height: height,
          width: width,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
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
  final double borderRadius;
  final BoxFit? fit;

  const NetworkImageWithRetry({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
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
  String image = "";

  void setImageFunction() {
    appLog("network image url : ${widget.imageUrl}");
    try {
      if (widget.imageUrl.contains("null")) {
        image = "";
      } else if (widget.imageUrl.startsWith("http") || widget.imageUrl.startsWith("https")) {
        image = widget.imageUrl;
      } else {
        image = "${Urls.imageBaseUrl}${widget.imageUrl}";
      }
    } catch (e) {
      image = "";
      errorLog("error form network image set image path function : ", e);
    }

    appLog(
      "final image url : $image",
    );
  }

  @override
  void initState() {
    setImageFunction();
    super.initState();
  }

  // Retry function in case of failure
  void _retry() async {
    try {
      if (_retryCount < _maxRetries) {
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _retryCount++;
          });
        });
      }
    } catch (e) {
      log("error network image retry function: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = CustomHttpClient();
    return image.isNotEmpty
        ? Image.network(
            image,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            // Handling error when image fails to load
            errorBuilder: (context, error, stackTrace) {
              errorLog("image url path : $image", error);
              errorLog("Error loading image:, Retry Count: $_retryCount", error);
              _retry();

              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  // color: AppColors.primary, // Placeholder color on error
                  child: const Icon(Icons.image_not_supported, color: Colors.white), // Fallback icon
                ),
              );
            },
            // Showing a placeholder while image is loading
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  // color: AppColors.primary, // Loading placeholder color
                ),
              );
            },
          )
        : SizedBox(
            width: widget.width,
            height: widget.height,
            // color: AppColors.primary, // Placeholder color on error
            child: const Icon(Icons.image_not_supported, color: Colors.white), // Fallback icon
          );
  }
}
