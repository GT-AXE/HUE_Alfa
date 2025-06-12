import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CacheService {
  // نمط Singleton
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  // مرجع لـ SharedPreferences
  SharedPreferences? _prefs;
  
  // تهيئة الخدمة
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في تهيئة خدمة التخزين المؤقت: $e');
      }
    }
  }

  // التحقق من التهيئة
  bool get isInitialized => _prefs != null;
  
  void _checkInitialized() {
    if (!isInitialized) {
      throw Exception('خدمة التخزين المؤقت غير مهيأة. يرجى استدعاء init() أولاً.');
    }
  }

  // حفظ بيانات
  Future<bool> saveData(String key, dynamic value) async {
    _checkInitialized();
    
    try {
      if (value is String) {
        return await _prefs!.setString(key, value);
      } else if (value is int) {
        return await _prefs!.setInt(key, value);
      } else if (value is double) {
        return await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        return await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        return await _prefs!.setStringList(key, value);
      } else {
        // تحويل القيمة إلى JSON
        final jsonValue = jsonEncode(value);
        return await _prefs!.setString(key, jsonValue);
      }
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في حفظ البيانات: $e');
      }
      return false;
    }
  }

  // استرجاع بيانات
  dynamic getData(String key, {dynamic defaultValue}) {
    _checkInitialized();
    
    try {
      if (!_prefs!.containsKey(key)) {
        return defaultValue;
      }
      
      final value = _prefs!.get(key);
      
      // محاولة تحليل القيمة كـ JSON إذا كانت نصية
      if (value is String) {
        try {
          return jsonDecode(value);
        } catch (_) {
          return value;
        }
      }
      
      return value ?? defaultValue;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في استرجاع البيانات: $e');
      }
      return defaultValue;
    }
  }

  // حذف بيانات
  Future<bool> removeData(String key) async {
    _checkInitialized();
    
    try {
      if (_prefs!.containsKey(key)) {
        return await _prefs!.remove(key);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في حذف البيانات: $e');
      }
      return false;
    }
  }

  // مسح جميع البيانات
  Future<bool> clearAll() async {
    _checkInitialized();
    
    try {
      return await _prefs!.clear();
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في مسح جميع البيانات: $e');
      }
      return false;
    }
  }
}



