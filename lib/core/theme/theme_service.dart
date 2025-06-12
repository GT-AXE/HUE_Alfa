import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  static const String _key = 'isDarkMode';

  // الحصول على وضع السمة الحالي
  static Future<ThemeMode> getThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_key) ?? false;
      return isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      return ThemeMode.system;
    }
  }

  // تحميل حالة السمة من التخزين
  static Future<bool> _loadThemeFromBox() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false;
    } catch (e) {
      return false;
    }
  }

  // حفظ حالة السمة في التخزين
  static Future<void> _saveThemeToBox(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, isDarkMode);
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  // تبديل السمة
  static Future<void> switchTheme() async {
    try {
      final currentIsDark = await _loadThemeFromBox();
      final newThemeMode = currentIsDark ? ThemeMode.light : ThemeMode.dark;
      Get.changeThemeMode(newThemeMode);
      await _saveThemeToBox(!currentIsDark);
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  // تطبيق السمة المحفوظة
  static Future<void> applyStoredTheme() async {
    try {
      final themeMode = await getThemeMode();
      Get.changeThemeMode(themeMode);
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF2196F3),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFF03DAC6),
        error: Color(0xFFE53935),
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textTheme: GoogleFonts.cairoTextTheme().copyWith(
        titleLarge: GoogleFonts.cairo(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.cairo(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.cairo(
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.cairo(
          color: Colors.black54,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1976D2),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1976D2),
        secondary: Color(0xFF03DAC6),
        error: Color(0xFFE53935),
        surface: Color(0xFF1E1E1E),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFF1976D2),
        unselectedItemColor: Colors.grey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF1E1E1E),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.cairo(
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.cairo(
          color: Colors.white70,
        ),
      ),
    );
  }
}