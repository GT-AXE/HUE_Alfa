import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hue/core/utils/constants.dart';

class ErrorHandler {
  // منع إنشاء نسخة من الكلاس
  ErrorHandler._();
  
  // تهيئة معالج الأخطاء
  static Future<void> initialize() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      reportError(details.exception, details.stack);
    };
  }
  
  // تسجيل الخطأ
  static void reportError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      debugPrint('خطأ: $error');
      if (stackTrace != null) {
        debugPrint('تتبع الخطأ: $stackTrace');
      }
    }
    
    // في الإنتاج، يمكن إرسال الخطأ إلى خدمة تتبع الأخطاء
    // مثال: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
  
  // بناء واجهة خطأ مخصصة
  static Widget buildErrorWidget(String message) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'حدث خطأ أثناء عرض هذا المحتوى',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
  
  // معالجة أخطاء Supabase
  static String handleSupabaseError(dynamic error) {
    if (error == null) {
      return Constants.unknownError;
    }
    
    final errorMessage = error.toString().toLowerCase();
    
    if (errorMessage.contains('invalid login credentials')) {
      return 'بيانات تسجيل الدخول غير صحيحة';
    }
    
    if (errorMessage.contains('email not confirmed')) {
      return 'يرجى تأكيد البريد الإلكتروني أولاً';
    }
    
    if (errorMessage.contains('user already registered')) {
      return 'البريد الإلكتروني مسجل بالفعل';
    }
    
    if (errorMessage.contains('weak password')) {
      return 'كلمة المرور ضعيفة';
    }
    
    if (errorMessage.contains('invalid email')) {
      return 'البريد الإلكتروني غير صالح';
    }
    
    if (errorMessage.contains('network')) {
      return Constants.networkError;
    }
    
    return Constants.unknownError;
  }
  
  // معالجة أخطاء الشبكة
  static String handleNetworkError(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'لا يمكن الاتصال بالخادم. تحقق من اتصالك بالإنترنت.';
    }
    
    if (error.toString().contains('TimeoutException')) {
      return 'انتهت مهلة الاتصال. حاول مرة أخرى لاحق<|im_start|>.';
    }
    
    if (error.toString().contains('HttpException')) {
      return 'حدث خطأ في الطلب. حاول مرة أخرى لاحق�ん.';
    }
    
    return Constants.networkError;
  }
}