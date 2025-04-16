import 'package:flutter/material.dart';

/// الألوان العامة للتطبيق
class AppColors {
  static const Color primary = Colors.lightBlue; // اللون الأساسي
  static const Color bubbleSelf = Colors.amber; // فقاعات المستخدم
  static const Color bubbleOther = Color(0xFFF0F0F0); // فقاعات الطرف الآخر
  static const Color textSelf = Colors.white; // النص داخل فقاعة المستخدم
  static const Color textOther = Colors.black; // النص داخل فقاعة الطرف الآخر
}

/// ألوان مخصصة لصفحة "Home"
class HomeColors {
  static const Color appBarColor = Colors.blue;
  static const Color bottomNavBarSelected = Colors.yellow;
  static const Color bottomNavBarUnselected = Colors.blue;
  static const Color adCardColor = Colors.white;
  static const Color adCardTextColor = Colors.blueAccent;
  static const Color adGridBackground = Color(0xFFF0F0F0);
}

/// ألوان مخصصة لصفحة "Welcome"
class WelcomeColors {
  static const Color darkBlue = Color(0xFF0C1D6B);
  static const Color yellow = Color.fromARGB(223, 255, 196, 0);
  static const Color backgroundLight = Color(0xFFA8D0E6);
  static const Color backgroundDark = Colors.black;
}

/// ألوان مخصصة لصفحة "Settings"
class SettingsColors {
  static const Color appBarGradientStart = Colors.blueAccent;
  static const Color appBarGradientEnd = Colors.lightBlue;
  static const Color backgroundStart = Color(0xFFF5F5F5);
  static const Color backgroundEnd = Color(0xFFEEEEEE);
  static const Color iconColor = Colors.blueAccent;
  static const Color arrowColor = Colors.blueAccent;
}

/// ألوان مخصصة لصفحة "Doctors"
class DoctorsColors {
  static const Color appBarGradientStart = Color(0xFF2A75BC);
  static const Color appBarGradientEnd = Color(0xFF33B0E0);
  static const Color backgroundStart = Color(0xFFF5F5F5);
  static const Color backgroundEnd = Color(0xFFE8F4F8);
  static const Color nameText = Color(0xFF2A3C4E);
  static const Color specialtyText = Color(0xFF607D8B);
  static const Color starColor = Color(0xFFFFC107);
  static const Color experienceIcon = Color(0xFF33B0E0);
  static const Color experienceText = Color(0xFF607D8B);
  static const Color buttonColor = Color(0xFF2A75BC);
  static const Color snackBarColor = Color(0xFF2A75BC);
}

/// الألوان العامة للتطبيق
class StudentsPageColors {
  static const Color primary =  Color(0xFF2A75BC); // اللون الأساسي
  static const Color sectionTitle = Color.fromARGB(255, 0, 0, 0); // عنوان قسم الخدمات

  /// ألوان مخصصة لصفحة "StudentsPage"
  static const Color serviceCard1 = Color(0xFF6A11CB); // Course Catalog
  static const Color serviceCard2 = Color(0xFF2575FC); // Class Schedule
  static const Color serviceCard3 = Color(0xFF4CAF50); // Academic Grades
  static const Color serviceCard4 = Color(0xFFFF9800); // Attendance Tracker
  static const Color serviceCard5 = Color(0xFFE91E63); // Course Registration
  static const Color serviceCard6 = Color(0xFF009688); // Student Community
  static const Color serviceCard7 = Color.fromARGB(255, 87, 62, 53); // Academic Support
  static const Color serviceCard8 = Color(0xFFFFC107); // Fee Management
}

/// ألوان مخصصة لصفحة "UniversitiesPage"
class UniversitiesColors {
  static const Color appBarGradientStart = Color(0xFF2A75BC); // بداية تدرج شريط العنوان
  static const Color appBarGradientEnd = Color(0xFF33B0E0);   // نهاية التدرج

  static const Color backgroundStart = Color(0xFFF5F5F5); // خلفية علوية للصفحة
  static const Color backgroundEnd = Color(0xFFDCEEF2);   // خلفية سفلية للصفحة

  static const Color cardShadow = Colors.blueGrey;        // ظل الكروت
  static const Color cardGradientStart = Colors.white;    // تدرج الكارت (أبيض)
  static const Color cardGradientEnd = Color(0xFFE3F2FD); // أزرق فاتح جدًا

  static const Color iconBackground = Colors.white;       // خلفية الأيقونة
  static const Color iconShadow = Colors.blue;            // ظل الأيقونة

  static const Color textColor = Color(0xFF2A3256);       // لون اسم الكلية
}

/// ألوان مخصصة لصفحة "DepartmentPage"
class DepartmentColors {
  static const Color appBarColor = Colors.teal; // لون البار العلوي
  static const Color bodyGradientStart = Color(0xFFE0F2F1); // Colors.teal.shade50
  static const Color bodyGradientMiddle = Color(0xFFB2DFDB); // Colors.teal.shade100
  static const Color bodyGradientEnd = Colors.white;

  static const Color cardSplashColor = Colors.teal;
  static const Color cardHighlightColor = Color(0x0D008080); // Colors.teal.withOpacity(0.05)
  
  static const Color cardGradientStart = Color(0xFFB2DFDB); // Colors.teal.shade100
  static const Color cardGradientMiddle = Color(0xFFE0F2F1); // Colors.teal.shade50
  static const Color cardGradientEnd = Colors.white;

  static const Color cardImageBackground = Color(0xFFE0F2F1); // Colors.teal.shade50
  static const Color cardImageErrorColor = Color(0xFF00796B); // Colors.teal.shade700

  static const Color cardTitleColor = Color(0xFF004D40); // Colors.teal.shade900

  static const Color emptyStateIconColor = Color(0xFF4DB6AC); // Colors.teal.shade300
  static const Color emptyStateTextColor = Color(0xFF757575); // Colors.grey.shade600
}
/// ألوان مخصصة لصفحة "Login"

class LoginColors {
  // الألوان الرئيسية
  static const primaryColor = Color(0xFFF3B818); // اللون الأصفر
  static const secondaryColor = Color(0xFF141E7A); // اللون الأزرق

  // الألوان الثانوية
  static const greyColor = Color(0xFF9E9E9E); // اللون الرمادي
  static const backgroundColor = Color(0xFFF5F5F5); // لون خلفية
  static const buttonTextColor = Colors.white;

  // ألوان خاصة
  static const errorColor = Colors.red;
  static const warningColor = Color(0xFFC28D00); // اللون البرتقالي الغامق
}

/// ألوان مخصصة لصفحة "reset_password"
class resetColors {
  // الألوان الرئيسية
  static const primaryColor = Color(0xFFF3B818); // اللون الأصفر
  static const secondaryColor = Color(0xFF141E7A); // اللون الأزرق

  // الألوان الثانوية
  static const greyColor = Color(0xFF9E9E9E); // اللون الرمادي
  static const backgroundColor = Color(0xFFF5F5F5); // لون خلفية
  static const buttonTextColor = Colors.white;

  // ألوان خاصة
  static const errorColor = Colors.red;
  static const warningColor = Color(0xFFC28D00); // اللون البرتقالي الغامق
  static const appBarColor = Colors.deepPurple; // لون شريط العنوان
}

/// ألوان مخصصة لصفحة "SignUp"
class SignUpColors {
  // الألوان الرئيسية
  static const primaryColor = Color(0xFFF3B818); // اللون الأصفر
  static const secondaryColor = Color(0xFF141E7A); // اللون الأزرق

  // الألوان الثانوية
  static const greyColor = Color(0xFF9E9E9E); // اللون الرمادي
  static const backgroundColor = Color(0xFFF5F5F5); // لون خلفية
  static const buttonTextColor = Colors.white;

  // ألوان خاصة
  static const errorColor = Colors.red;
  static const warningColor = Color(0xFFC28D00); // اللون البرتقالي الغامق
  static const appBarColor = Colors.deepPurple; // لون شريط العنوان
  static const signUpButtonColor = Colors.deepPurple; // اللون الخاص بزر التسجيل
}

/// ألوان مخصصة لصفحة "Submissions"
class SubmissionsColors {
  // الألوان الرئيسية
  static const primaryColor = Color(0xFFF3B818); // اللون الأصفر
  static const secondaryColor = Color(0xFF141E7A); // اللون الأزرق

  // الألوان الثانوية
  static const greyColor = Color(0xFF9E9E9E); // اللون الرمادي
  static const backgroundColor = Color(0xFFF5F5F5); // لون خلفية
  static const buttonTextColor = Colors.white;

  // ألوان خاصة
  static const errorColor = Colors.red;
  static const warningColor = Color(0xFFC28D00); // اللون البرتقالي الغامق
  static const appBarColor = Colors.deepPurple; // لون شريط العنوان
  static const buttonColor = Colors.deepPurple; // اللون الخاص بزر الإرسال
  static const cardBackgroundColor = Color(0xFFEDEDED); // لون خلفية البطاقة
}