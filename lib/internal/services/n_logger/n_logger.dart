// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

class NDebugger {
  static void handleException(Object e, [StackTrace? stackTrace]) => NLogger.handleException(e, stackTrace);
}

class NLogger {
  static void handleException(Object e, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      log(e.toString());
      if (stackTrace != null) log(stackTrace.toString());
    }
  }
}
