import 'package:flutter/material.dart';
import '../models/role.dart';
import '../utils/role_manager.dart';

class AccessGuard extends StatelessWidget {
  final List<Role> requiredRoles;
  final Role currentUserRole;
  final Widget child;

  const AccessGuard({
    required this.requiredRoles,
    required this.currentUserRole,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!RoleManager.hasAccess(currentUserRole, requiredRoles)) {
      return Scaffold(
        appBar: AppBar(title: Text("🚫 لا تملك صلاحية")),
        body: Center(
          child: Text('🚫 ليس لديك صلاحية الوصول لهذه الصفحة'),
        ),
      );
    }

    return child;
  }
}
