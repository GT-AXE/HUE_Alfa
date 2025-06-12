import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/core/services/error_handler.dart';
import 'package:hue/core/services/secure_storage_service.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();
  
  // حالة تحميل التطبيق
  final RxBool isLoading = false.obs;
  
  // حالة المصادقة
  final RxBool isLoggedIn = false.obs;
  
  // معلومات المستخدم
  final Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  
  // مرجع Supabase
  final SupabaseClient supabase = Supabase.instance.client;
  
  // خدمة التخزين الآمن
  final SecureStorageService _secureStorage = SecureStorageService();
  
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  
  // التحقق من حالة تسجيل الدخول
  Future<void> checkLoginStatus() async {
    isLoading.value = true;
    
    try {
      // التحقق من وجود جلسة نشطة في Supabase
      final session = supabase.auth.currentSession;
      
      if (session != null && !session.isExpired) {
        isLoggedIn.value = true;
        await getUserData();
      } else {
        isLoggedIn.value = false;
        userData.value = {};
      }
    } catch (e) {
      isLoggedIn.value = false;
      ErrorHandler.reportError(e, null);
    } finally {
      isLoading.value = false;
    }
  }
  
  // الحصول على بيانات المستخدم
  Future<void> getUserData() async {
    try {
      if (!isLoggedIn.value) return;
      
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;
      
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      userData.value = response;
    } catch (e) {
      ErrorHandler.reportError(e, null);
    }
  }
  
  // تسجيل الخروج
  Future<void> logout() async {
    isLoading.value = true;
    
    try {
      await supabase.auth.signOut();
      await _secureStorage.clearAll();
      isLoggedIn.value = false;
      userData.value = {};
    } catch (e) {
      ErrorHandler.reportError(e, null);
    } finally {
      isLoading.value = false;
    }
  }
  
  // تحديث بيانات المستخدم
  Future<bool> updateUserData(Map<String, dynamic> data) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return false;
      
      final response = await supabase
          .from('profiles')
          .update(data)
          .eq('id', userId)
          .select()
          .single();
      
      userData.value = response;
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // التحقق من صحة الجلسة
  Future<bool> validateSession() async {
    try {
      final session = supabase.auth.currentSession;
      
      if (session == null || session.isExpired) {
        isLoggedIn.value = false;
        userData.value = {};
        return false;
      }
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
}