class Constants {
  // منع إنشاء نسخة من الكلاس
  Constants._();
  
  // Supabase Configuration
  static const String supabaseUrl = 'https://judwcjkwjwsamlenstfs.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1ZHdjamt3andzYW1sZW5zdGZzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyMTY3NTMsImV4cCI6MjA1NTc5Mjc1M30.8j4oUsmaq7IQT76UigkOpha39O3CRK-yuBvZIVe3bC8';
  
  // Storage Keys
  static const String userSessionKey = 'user_session';
  static const String deviceIdKey = 'device_id';
  static const String appSignatureKey = 'app_signature';
  static const String sessionUuidKey = 'session_uuid';
  static const String securityTokenKey = 'security_token';
  static const String themeKey = 'theme_mode';
  
  // Security
  static const String encryptionSalt = 'hue_app_salt_2024';
  static const String emailDomain = 'horus.edu.eg';
  
  // App Settings
  static const int sessionTimeoutMinutes = 30;
  static const int maxLoginAttempts = 5;
  static const Duration cacheExpiration = Duration(days: 7);
  static const Duration snackBarDuration = Duration(seconds: 3);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 4.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Error Messages
  static const String invalidEmailDomain = 'يجب استخدام بريد إلكتروني من نطاق @horus.edu.eg';
  static const String invalidPassword = 'كلمة المرور يجب أن تكون على الأقل 8 أحرف';
  static const String passwordMismatch = 'كلمة المرور وتأكيد كلمة المرور لا يتطابقان';
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String unknownError = 'حدث خطأ غير متوقع';
  
  // Development Mode
  static const bool isDevelopment = true; // تغيير إلى false في الإنتاج
}
