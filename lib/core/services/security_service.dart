import 'package:flutter/foundation.dart';
import 'package:hue/core/utils/constants.dart';
import 'package:hue/core/services/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:hue/core/services/error_handler.dart';

class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();
  
  final SecureStorageService _secureStorage = SecureStorageService();
  
  // فحص أمان التطبيق
  Future<bool> isAppSecure() async {
    try {
      // في وضع التطوير، نعتبر التطبيق آمنًا دائمًا
      if (Constants.isDevelopment && kDebugMode) {
        return true;
      }
      
      // التحقق من وجود علامة الأمان
      final securityToken = await _secureStorage.getSecureData(Constants.securityTokenKey);
      
      // إذا لم تكن موجودة، نقوم بإنشائها
      if (securityToken == null) {
        final newToken = DateTime.now().millisecondsSinceEpoch.toString();
        await _secureStorage.saveSecureData(Constants.securityTokenKey, newToken);
        return true;
      }
      
      // التحقق من صحة العلامة
      return securityToken.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في فحص أمان التطبيق: $e');
      }
      return false;
    }
  }
  
  // فحص إذا كان التطبيق معدل
  Future<bool> isAppTampered() async {
    try {
      // في وضع التطوير، نفترض أن التطبيق غير معدل
      if (kDebugMode) {
        return false;
      }
      
      // الحصول على معلومات الحزمة
      final packageInfo = await PackageInfo.fromPlatform();
      
      // التحقق من اسم الحزمة
      if (packageInfo.packageName != 'com.example.hue') {
        return true;
      }
      
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في فحص تعديل التطبيق: $e');
      }
      return true; // نفترض وجود تعديل في حالة الخطأ
    }
  }
  
  // تسجيل محاولة وصول غير مصرح بها
  Future<void> logSecurityViolation(String type, String details) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final violations = prefs.getStringList('security_violations') ?? [];
      
      final timestamp = DateTime.now().toIso8601String();
      violations.add('$timestamp - $type: $details');
      
      // الاحتفاظ بآخر 10 انتهاكات فقط
      if (violations.length > 10) {
        violations.removeRange(0, violations.length - 10);
      }
      
      await prefs.setStringList('security_violations', violations);
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في تسجيل انتهاك الأمان: $e');
      }
    }
  }
  
  // إعادة تعيين حالة الأمان
  Future<void> resetSecurityState() async {
    try {
      await _secureStorage.deleteSecureData(Constants.securityTokenKey);
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في إعادة تعيين حالة الأمان: $e');
      }
    }
  }
  
  // التحقق من صحة الجلسة
  Future<bool> validateSession() async {
    try {
      // التحقق من وجود علامة الجلسة
      final sessionToken = await _secureStorage.getSecureData(Constants.userSessionKey);
      
      if (sessionToken == null || sessionToken.isEmpty) {
        return false;
      }
      
      // يمكن إضافة منطق إضافي للتحقق من صلاحية الجلسة
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في التحقق من صحة الجلسة: $e');
      }
      return false;
    }
  }
}





