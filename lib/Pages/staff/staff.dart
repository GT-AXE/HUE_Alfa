import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/core/models/role.dart';
import 'package:hue/core/controllers/role_manager.dart';
import 'package:hue/core/utils/app_colors.dart';


class StaffPage extends StatelessWidget {
  final Role userRole; 

  StaffPage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page"),
        backgroundColor: staffColors.primary,
      ),
      body: ListView(
        children: [
          _buildSection("Administration", RoleManager.adminRoles, context),
          _buildSection("Faculty Members", RoleManager.facultyRoles, context),
          _buildSection("Administrative Staff", RoleManager.staffRoles, context),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Role> allowedRoles, BuildContext context) {
    bool hasPermission = RoleManager.hasAccess(userRole, allowedRoles);

    return Visibility(
      visible: hasPermission,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        color: staffColors.bubbleOther,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: staffColors.textOther, 
            ),
          ),
          subtitle: Text(
            "Access granted to: ${allowedRoles.join(", ")}",
            style: TextStyle(color: staffColors.textOther), 
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: staffColors.primary), 
            onPressed: () {
              _editSection(context, title);
            },
          ),
        ),
      ),
    );
  }

  void _editSection(BuildContext context, String title) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title", style: TextStyle(color: staffColors.primary)), 
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter new content",
              hintStyle: TextStyle(color: staffColors.textOther),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: staffColors.primary)),
            ),
            TextButton(
              onPressed: () {
                print("Content saved: ${controller.text}");
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: staffColors.primary)),
            ),
          ],
        );
      },
    );
  }
}
