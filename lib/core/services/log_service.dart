class StaffLogger {
  static final List<String> _logs = [];

  // دالة لإضافة اللوجات
  static void log(String message) {
    final timestamp = DateTime.now().toIso8601String();
    _logs.add("[$timestamp] $message");
    print("📘 LOG: [$timestamp] $message"); // يظهر بالكونسول
  }

  // دالة للحصول على جميع اللوجات
  static List<String> getLogs() => _logs;

  // دالة لمسح اللوجات
  static void clearLogs() {
    _logs.clear();
  }
}
