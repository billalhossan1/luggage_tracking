import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:luggage_tracking/utils/app_all_log/error_log.dart';

void appLog(dynamic message) {
  try {
    if (kDebugMode) {
      log(message.toString());
    }
  } catch (e) {
    errorLog("app log", e);
  }
}
