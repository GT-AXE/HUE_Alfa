import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../staff/roles.dart'; // استيراد ملف الأدوار

class AppColors {
  static const Color primary = Colors.lightBlue;
  static const Color bubbleSelf = Colors.amber;
  static const Color bubbleOther = Color(0xFFF0F0F0);
  static const Color textSelf = Colors.white;
  static const Color textOther = Colors.black;
}

class StaffPage extends StatelessWidget {
  final Role userRole; // دور المستخدم الحالي

  StaffPage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page"),
        backgroundColor: AppColors.primary, // استخدام اللون الأساسي في الـ AppBar
      ),
      body: ListView( // تغيير Column إلى ListView لدعم التمرير عند وجود العديد من الأقسام
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
        color: AppColors.bubbleOther, // استخدام اللون للـ Card
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: AppColors.textOther, // تغيير لون النص
            ),
          ),
          subtitle: Text(
            "Access granted to: ${allowedRoles.join(", ")}",
            style: TextStyle(color: AppColors.textOther), // تغيير لون النص في الـ subtitle
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: AppColors.primary), // استخدام اللون الأساسي للأيقونة
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
          title: Text("Edit $title", style: TextStyle(color: AppColors.primary)), // تغيير لون العنوان
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter new content",
              hintStyle: TextStyle(color: AppColors.textOther), // تغيير لون النص في الـ hint
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: AppColors.primary)), // استخدام اللون الأساسي في زر Cancel
            ),
            TextButton(
              onPressed: () {
                print("Content saved: ${controller.text}"); // استبدل هذه الوظيفة بالحفظ الفعلي
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: AppColors.primary)), // استخدام اللون الأساسي في زر Save
            ),
          ],
        );
      },
    );
  }
}
