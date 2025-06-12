import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class SecureStorageService {
  // استخدام SharedPreferences مع تشفير بسيط
  
  // حفظ بيانات آمنة
  Future<bool> saveSecureData(String key, String value, {String? password}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // في حالة وجود كلمة مرور، يمكن تنفيذ تشفير بسيط
      String dataToSave = value;
      if (password != null) {
        dataToSave = _simpleEncrypt(value, password);
      }
      
      return await prefs.setString(key, dataToSave);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في حفظ البيانات الآمنة: $e');
      }
      return false;
    }
  }
  
  // استرجاع بيانات آمنة
  Future<String?> getSecureData(String key, {String? password}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      
      if (value == null) return null;
      
      // فك التشفير إذا تم توفير كلمة مرور
      if (password != null) {
        return _simpleDecrypt(value, password);
      }
      
      return value;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في استرجاع البيانات الآمنة: $e');
      }
      return null;
    }
  }
  
  // حذف بيانات آمنة
  Future<bool> deleteSecureData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في حذف البيانات الآمنة: $e');
      }
      return false;
    }
  }
  
  // التحقق من وجود بيانات
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في التحقق من وجود البيانات: $e');
      }
      return false;
    }
  }
  
  // حذف جميع البيانات
  Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في حذف جميع البيانات: $e');
      }
      return false;
    }
  }
  
  // تشفير بسيط (للتوضيح فقط - غير آمن للإنتاج)
  String _simpleEncrypt(String text, String password) {
    try {
      final List<int> textBytes = text.codeUnits;
      final List<int> passwordBytes = password.codeUnits;
      final List<int> encrypted = [];
      
      for (int i = 0; i < textBytes.length; i++) {
        final int passwordIndex = i % passwordBytes.length;
        encrypted.add(textBytes[i] ^ passwordBytes[passwordIndex]);
      }
      
      return base64Encode(encrypted);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في التشفير: $e');
      }
      return text;
    }
  }
  
  // فك التشفير البسيط
  String _simpleDecrypt(String encryptedText, String password) {
    try {
      final List<int> encryptedBytes = base64Decode(encryptedText);
      final List<int> passwordBytes = password.codeUnits;
      final List<int> decrypted = [];
      
      for (int i = 0; i < encryptedBytes.length; i++) {
        final int passwordIndex = i % passwordBytes.length;
        decrypted.add(encryptedBytes[i] ^ passwordBytes[passwordIndex]);
      }
      
      return String.fromCharCodes(decrypted);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في فك التشفير: $e');
      }
      return encryptedText;
    }
  }
  
  // حفظ بيانات JSON
  Future<bool> saveJsonData(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      return await saveSecureData(key, jsonString);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في حفظ بيانات JSON: $e');
      }
      return false;
    }
  }
  
  // استرجاع بيانات JSON
  Future<Map<String, dynamic>?> getJsonData(String key) async {
    try {
      final jsonString = await getSecureData(key);
      if (jsonString == null) return null;
      
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('خطأ في استرجاع بيانات JSON: $e');
      }
      return null;
    }
  }
}