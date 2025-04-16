import '../models/role.dart';

class RoleManager {
  static const List<Role> allRoles = [
    Role.all,
    Role.all_admin,
    Role.all_student,
    Role.all_staff,
    Role.all_faculty,
  ];

  static const List<Role> adminRoles = [
    Role.admin,
    Role.manager,
    Role.dean,
  ];

  static const List<Role> facultyRoles = [
    Role.professor,
    Role.lecturer,
    Role.assistant,
  ];

  static const List<Role> staffRoles = [
    Role.hr,
    Role.secretary,
    Role.technician,
  ];

  static const List<Role> studentRoles = [
    Role.student_admin,
    Role.student_manager,
    Role.student,
  ];

  static bool hasAccess(Role userRole, List<Role> allowedRoles) {
    if (allowedRoles.contains(Role.all)) return true;

    if (allowedRoles.contains(Role.all_admin) && adminRoles.contains(userRole)) return true;
    if (allowedRoles.contains(Role.all_faculty) && facultyRoles.contains(userRole)) return true;
    if (allowedRoles.contains(Role.all_staff) && staffRoles.contains(userRole)) return true;
    if (allowedRoles.contains(Role.all_student) && studentRoles.contains(userRole)) return true;

    return allowedRoles.contains(userRole);
  }

  static String roleToString(Role role) {
    switch (role) {
      case Role.all:
        return 'All';
      case Role.all_admin:
        return 'All_Admin';
      case Role.all_student:
        return 'All_Student';
      case Role.all_staff:
        return 'All_Staff';
      case Role.all_faculty:
        return 'All_Faculty';

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

      case Role.student_admin:
        return 'Student Admin';
      case Role.student_manager:
        return 'Student Manager';
      case Role.student:
        return 'Student';
      case Role.guest:
        return 'Guest';
    }
  }
}
