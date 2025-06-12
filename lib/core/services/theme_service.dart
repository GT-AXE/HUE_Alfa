import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hue/core/utils/constants.dart';

class ThemeService {
  // منع إنشاء نسخة من الكلاس
  ThemeService._();
  
  // الحصول على وضع السمة المخزن
  static Future<ThemeMode> getThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(Constants.themeKey);
      
      if (themeIndex == null) {
        return ThemeMode.system;
      }
      
      // التأكد من أن القيمة ضمن النطاق المسموح
      if (themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
        return ThemeMode.values[themeIndex];
      }
      
      return ThemeMode.system;
    } catch (e) {
      debugPrint('خطأ في الحصول على وضع السمة: $e');
      return ThemeMode.system;
    }
  }
  
  // حفظ وضع السمة
  static Future<bool> saveThemeMode(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(Constants.themeKey, mode.index);
    } catch (e) {
      debugPrint('خطأ في حفظ وضع السمة: $e');
      return false;
    }
  }
  
  // تبديل وضع السمة
  static Future<void> toggleTheme() async {
    try {
      final currentTheme = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
      Get.changeThemeMode(currentTheme);
      await saveThemeMode(currentTheme);
    } catch (e) {
      debugPrint('خطأ في تبديل وضع السمة: $e');
    }
  }
  
  // تطبيق وضع السمة المحفوظ
  static Future<void> applyStoredTheme() async {
    try {
      final themeMode = await getThemeMode();
      Get.changeThemeMode(themeMode);
    } catch (e) {
      debugPrint('خطأ في تطبيق وضع السمة المحفوظ: $e');
    }
  }
  
  // التحقق مما إذا كان الوضع الداكن مفعل
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
  // تعيين وضع السمة
  static Future<void> setThemeMode(ThemeMode mode) async {
    try {
      Get.changeThemeMode(mode);
      await saveThemeMode(mode);
    } catch (e) {
      debugPrint('خطأ في تعيين وضع السمة: $e');
    }
  }
  
  // الحصول على وضع السمة الحالي
  static ThemeMode getCurrentThemeMode() {
    if (Get.isDarkMode) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
  
  // تهيئة السمة عند بدء التطبيق
  static Future<void> initializeTheme() async {
    try {
      await applyStoredTheme();
    } catch (e) {
      debugPrint('خطأ في تهيئة السمة: $e');
    }
  }
  
  // الحصول على لون أساسي حسب السمة
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  // الحصول على لون الخلفية حسب السمة
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  // الحصول على لون النص حسب السمة
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }

  // الحصول على لون السطح حسب السمة
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }
}



