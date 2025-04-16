import 'package:flutter/material.dart';

/// Enum لتعريف الأدوار Roles
enum Role {
  admin,
  manager,
  dean,
  professor,
  lecturer,
  assistant,
  hr,
  secretary,
  technician,
  guest,
}

/// كلاس مسؤول عن من له صلاحية للوصول لكل قسم
class RoleManager {
  /// صلاحيات الإدارة العليا
  static const List<Role> adminRoles = [
    Role.admin,
    Role.manager,
    Role.dean,
  ];

  /// أعضاء هيئة التدريس
  static const List<Role> facultyRoles = [
    Role.professor,
    Role.lecturer,
    Role.assistant,
  ];

  /// الموظفون الإداريون
  static const List<Role> staffRoles = [
    Role.hr,
    Role.secretary,
    Role.technician,
  ];

  /// دالة فحص إذا كان الدور له صلاحية الوصول للقائمة
  static bool hasAccess(Role userRole, List<Role> allowedRoles) {
    return allowedRoles.contains(userRole);
  }

  /// إظهار اسم الدور كـ نص
  static String roleToString(Role role) {
    switch (role) {
      case Role.admin:
        return 'Admin';
      case Role.manager:
        return 'Manager';
      case Role.dean:
        return 'Dean';
      case Role.professor:
        return 'Professor';
      case Role.lecturer:
        return 'Lecturer';
      case Role.assistant:
        return 'Assistant';
      case Role.hr:
        return 'HR';
      case Role.secretary:
        return 'Secretary';
      case Role.technician:
        return 'Technician';
      case Role.guest:
        return 'Guest';
    }
  }
}
