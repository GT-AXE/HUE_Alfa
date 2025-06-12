import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkService {
  // نمط Singleton
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  // حالة الاتصال
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  // التحقق من الاتصال بالإنترنت
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      _isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return _isConnected;
    } on SocketException catch (_) {
      _isConnected = false;
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في التحقق من الاتصال: $e');
      }
      _isConnected = false;
      return false;
    }
  }

  // تنفيذ طلب مع إعادة المحاولة
  Future<T> executeWithRetry<T>({
    required Future<T> Function() request,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    int attempts = 0;
    
    while (true) {
      try {
        attempts++;
        return await request();
      } catch (e) {
        if (attempts >= maxRetries) {
          if (kDebugMode) {
            print('فشل الطلب بعد $maxRetries محاولات: $e');
          }
          rethrow;
        }
        
        if (kDebugMode) {
          print('إعادة المحاولة $attempts من $maxRetries بعد ${retryDelay.inSeconds} ثوان');
        }
        
        await Future.delayed(retryDelay);
      }
    }
  }

  // معالجة أخطاء الشبكة
  String handleNetworkError(dynamic error) {
    if (error is SocketException) {
      return 'لا يمكن الاتصال بالخادم. تحقق من اتصالك بالإنترنت.';
    } else if (error is TimeoutException) {
      return 'انتهت مهلة الاتصال. حاول مرة أخرى لاحقًا.';
    } else if (error is HttpException) {
      return 'حدث خطأ في الطلب. حاول مرة أخرى لاحقًا.';
    } else {
      return 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.';
    }
  }
}


