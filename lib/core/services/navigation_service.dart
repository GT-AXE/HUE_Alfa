import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/core/utils/constants.dart';

class NavigationService {
  // منع إنشاء نسخة من الكلاس
  NavigationService._();
  
  // التنقل إلى صفحة جديدة
  static Future<T?> navigateTo<T>(Widget page, {bool replace = false}) {
    if (replace) {
      return Get.off(() => page) ?? Future.value(null);
    } else {
      return Get.to(() => page) ?? Future.value(null);
    }
  }

  // التنقل إلى صفحة جديدة وحذف كل الصفحات السابقة
  static Future<T?> navigateAndRemoveUntil<T>(Widget page) {
    return Get.offAll(() => page) ?? Future.value(null);
  }

  // الرجوع للصفحة السابقة
  static void goBack<T>([T? result]) {
    if (canGoBack()) {
      Get.back(result: result);
    }
  }

  // التنقل باستخدام الاسم
  static Future<T?> navigateToNamed<T>(
    String routeName, {
    dynamic arguments,
    bool replace = false,
  }) {
    if (replace) {
      return Get.offNamed(routeName, arguments: arguments) ?? Future.value(null);
    } else {
      return Get.toNamed(routeName, arguments: arguments) ?? Future.value(null);
    }
  }

  // عرض رسالة تنبيه
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'نعم',
    String cancelText = 'إلغاء',
    Color? confirmColor,
    Color? cancelColor,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          title,
          style: Get.textTheme.titleLarge,
        ),
        content: Text(
          message,
          style: Get.textTheme.bodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            style: TextButton.styleFrom(
              foregroundColor: cancelColor ?? Colors.grey,
            ),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ?? Get.theme.primaryColor,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // عرض رسالة خطأ
  static void showErrorSnackbar(
    String message, {
    String title = 'خطأ',
    Duration duration = Constants.snackBarDuration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
    );
  }

  // عرض رسالة نجاح
  static void showSuccessSnackbar(
    String message, {
    String title = 'نجاح',
    Duration duration = Constants.snackBarDuration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
    );
  }

  // عرض رسالة تحذير
  static void showWarningSnackbar(
    String message, {
    String title = 'تحذير',
    Duration duration = Constants.snackBarDuration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration,
      icon: const Icon(
        Icons.warning_outlined,
        color: Colors.white,
      ),
      shouldIconPulse: false,
    );
  }

  // عرض رسالة معلومات
  static void showInfoSnackbar(
    String message, {
    String title = 'معلومات',
    Duration duration = Constants.snackBarDuration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration,
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
    );
  }

  // عرض مؤشر التحميل
  static void showLoading({
    String message = 'جاري التحميل...',
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // إخفاء مؤشر التحميل
  static void hideLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  // عرض نافذة منبثقة مخصصة
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return Get.dialog<T>(
      child,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }

  // عرض ورقة سفلية
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  // التحقق من إمكانية الرجوع
  static bool canGoBack() {
    try {
      return Get.key.currentState?.canPop() ?? false;
    } catch (e) {
      return false;
    }
  }

  // الحصول على الصفحة الحالية
  static String? getCurrentRoute() {
    return Get.currentRoute;
  }

  // الحصول على المعاملات المرسلة
  static dynamic getArguments() {
    return Get.arguments;
  }

  // إعادة تحميل الصفحة الحالية
  static void reloadCurrentPage() {
    final currentRoute = Get.currentRoute;
    if (currentRoute.isNotEmpty) {
      Get.offAndToNamed(currentRoute);
    }
  }

  // التنقل إلى الصفحة السابقة مع إزالة الصفحة الحالية
  static void popAndPush(Widget page) {
    Get.back();
    Get.to(() => page);
  }
}



