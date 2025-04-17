import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/core/models/role.dart';
import 'package:hue/core/controllers/role_manager.dart';
import 'package:hue/core/utils/app_colors.dart';

class StaffPage extends StatefulWidget {
  final Role userRole;

  StaffPage({required this.userRole});

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  String selectedSection = "Administration"; // Default selected section

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        backgroundColor: staffColors.primary,
        elevation: 4,
      ),
      drawer: Drawer(
        child: Container(
          color: staffColors.primary,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildDrawerHeader(),
              _buildDrawerItem("Administration"),
              _buildDrawerItem("Faculty Members"),
              _buildDrawerItem("Student Services"),
              _buildDrawerItem("Management"),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Left side with sections list (Drawer content)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  _buildSection("Administration", RoleManager.adminRoles, context),
                  _buildSection("Faculty Members", RoleManager.facultyRoles, context),
                  _buildSection("Student Services", RoleManager.studentRoles, context),
                  _buildSection("Management", RoleManager.staffRoles, context),
                ],
              ),
            ),
          ),
          // Right side with content display
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _buildContentDisplay(selectedSection),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the Drawer header
  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: staffColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          "Staff Sections",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Function to build each section item in the Drawer
  Widget _buildDrawerItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: staffColors.textOther,
        ),
      ),
      onTap: () {
        setState(() {
          selectedSection = title;
        });
        Navigator.pop(context); // Close the drawer after selection
      },
      trailing: Icon(Icons.arrow_forward_ios, color: staffColors.primary),
    );
  }

  // Function to build each section on the left side
  Widget _buildSection(String title, List<Role> allowedRoles, BuildContext context) {
    bool hasPermission = RoleManager.hasAccess(widget.userRole, allowedRoles);

    return Visibility(
      visible: hasPermission,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        color: staffColors.bubbleOther,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            style: TextStyle(color: staffColors.textOther.withOpacity(0.7)),
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

  // Function to display content based on the selected section
  Widget _buildContentDisplay(String section) {
    return Card(
      elevation: 5,
      color: staffColors.bubbleOther,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$section Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: staffColors.textOther,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Information related to $section will be displayed here. You can update details or manage sections.",
              style: TextStyle(color: staffColors.textOther.withOpacity(0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "Additional information or options can be added here for $section.",
              style: TextStyle(color: staffColors.textOther.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle editing section content
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
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: staffColors.primary),
              ),
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
