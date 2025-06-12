import 'package:flutter/foundation.dart';

class LoggerService {
  // تسجيل معلومات
  void logInfo(String message) {
    if (kDebugMode) {
      print('INFO: $message');
    }
  }

  // تسجيل تحذير
  void logWarning(String message) {
    if (kDebugMode) {
      print('WARNING: $message');
    }
  }

  // تسجيل خطأ
  void logError(String message, dynamic error, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      print('ERROR: $message');
      print('DETAILS: $error');
      if (stackTrace != null) {
        print('STACK TRACE:');
        print(stackTrace);
      }
    }
  }
}
