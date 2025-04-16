import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildCustomDivider(),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: adminItems.length,
                  itemBuilder: (context, index) {
                    final item = adminItems[index];
                    return _buildAdminItem(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Admin Panel',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      elevation: 8,
      backgroundColor: Colors.blueAccent.shade700,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Admin Dashboard",
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Manage university operations efficiently",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomDivider() {
    return Divider(
      thickness: 2,
      color: Colors.blue.shade400,
    );
  }

  Widget _buildAdminItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item['page']),
      ),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.15),
            radius: 25,
            child: Icon(item['icon'], color: Colors.blue.shade700, size: 28),
          ),
          title: Text(
            item['title'],
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            item['subtitle'],
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> adminItems = [
    {
      'icon': Icons.supervisor_account,
      'title': 'Manage Students',
      'subtitle': 'View and manage student records',
      'page': ManageStudentsPage(),
    },
    {
      'icon': Icons.school,
      'title': 'Manage Professors',
      'subtitle': 'View and manage professor details',
      'page': ManageProfessorsPage(),
    },
    {
      'icon': Icons.menu_book,
      'title': 'Manage Courses',
      'subtitle': 'Add or modify university courses',
      'page': ManageCoursesPage(),
    },
    {
      'icon': Icons.schedule,
      'title': 'Class Schedules',
      'subtitle': 'Manage class timetables and schedules',
      'page': ClassSchedulesPage(),
    },
    {
      'icon': Icons.assignment,
      'title': 'Exams & Grades',
      'subtitle': 'Monitor exams and student grades',
      'page': ExamsGradesPage(),
    },
    {
      'icon': Icons.settings,
      'title': 'System Settings',
      'subtitle': 'Configure application settings',
      'page': SystemSettingsPage(),
    },
  ];
}


class ManageStudentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Students')),
      body: Center(child: Text('Students Management Page')),
    );
  }
}

class ManageProfessorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Professors')),
      body: Center(child: Text('Professors Management Page')),
    );
  }
}

class ManageCoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Courses')),
      body: Center(child: Text('Courses Management Page')),
    );
  }
}

class ClassSchedulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Class Schedules')),
      body: Center(child: Text('Schedules Management Page')),
    );
  }
}

class ExamsGradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exams & Grades')),
      body: Center(child: Text('Exams & Grades Management Page')),
    );
  }
}

class SystemSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Settings')),
      body: Center(child: Text('System Settings Page')),
    );
  }
}