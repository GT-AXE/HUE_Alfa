import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/core/utils/constants.dart';
import 'package:hue/core/services/secure_storage_service.dart';
import 'package:hue/core/services/error_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();
  
  final SupabaseClient _supabase = Supabase.instance.client;
  final SecureStorageService _secureStorage = SecureStorageService();
  
  // التحقق من وجود جلسة نشطة
  Future<bool> hasActiveSession() async {
    try {
      final session = _supabase.auth.currentSession;
      
      if (session == null) {
        return false;
      }
      
      // التحقق من انتهاء صلاحية الجلسة
      if (session.isExpired) {
        await clearSession();
        return false;
      }
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // الحصول على المستخدم الحالي
  User? get currentUser => _supabase.auth.currentUser;
  
  // الحصول على الجلسة الحالية
  Session? get currentSession => _supabase.auth.currentSession;
  
  // حفظ بيانات الجلسة
  Future<void> saveSession(Session session) async {
    try {
      // حفظ معرف المستخدم
      await _secureStorage.saveSecureData(
        Constants.userSessionKey,
        session.user.id,
      );
      
      // حفظ معرف فريد للجلسة
      final sessionId = const Uuid().v4();
      await _secureStorage.saveSecureData(
        Constants.sessionUuidKey,
        sessionId,
      );
      
      // تسجيل معلومات الجلسة
      await _logSessionActivity(session, 'login');
    } catch (e) {
      ErrorHandler.reportError(e, null);
    }
  }
  
  // استرجاع بيانات الجلسة
  Future<String?> getStoredUserId() async {
    try {
      return await _secureStorage.getSecureData(Constants.userSessionKey);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // حذف بيانات الجلسة
  Future<void> clearSession() async {
    try {
      // تسجيل تسجيل الخروج
      final currentSession = _supabase.auth.currentSession;
      if (currentSession != null) {
        await _logSessionActivity(currentSession, 'logout');
      }
      
      // حذف البيانات المخزنة
      await _secureStorage.deleteSecureData(Constants.userSessionKey);
      await _secureStorage.deleteSecureData(Constants.sessionUuidKey);
    } catch (e) {
      ErrorHandler.reportError(e, null);
    }
  }
  
  // تسجيل الخروج
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      await clearSession();
    } catch (e) {
      ErrorHandler.reportError(e, null);
      // محاولة حذف البيانات المحلية على أي حال
      await clearSession();
    }
  }
  
  // تسجيل نشاط الجلسة
  Future<void> _logSessionActivity(Session session, String activity) async {
    try {
      // يمكن إضافة تسجيل في قاعدة البيانات هنا
      if (kDebugMode) {
        debugPrint('Session Activity: $activity for user ${session.user.id}');
      }
    } catch (e) {
      // تجاهل أخطاء التسجيل
      ErrorHandler.reportError(e, null);
    }
  }
  
  // التحقق من صحة الجلسة
  Future<bool> validateSession() async {
    try {
      final session = _supabase.auth.currentSession;
      
      if (session == null) {
        return false;
      }
      
      // التحقق من انتهاء الصلاحية
      if (session.isExpired) {
        await clearSession();
        return false;
      }
      
      // التحقق من وجود بيانات مخزنة
      final storedUserId = await getStoredUserId();
      if (storedUserId == null || storedUserId != session.user.id) {
        await clearSession();
        return false;
      }
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // تحديث الجلسة
  Future<void> refreshSession() async {
    try {
      await _supabase.auth.refreshSession();
    } catch (e) {
      ErrorHandler.reportError(e, null);
      await clearSession();
    }
  }
}
