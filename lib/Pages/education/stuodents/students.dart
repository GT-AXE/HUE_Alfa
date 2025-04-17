import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../stuodents/academic_grades.dart';
import '../stuodents/attendance_trackr.dart';
import '../stuodents/class_schedule.dart';
import '../stuodents/course_catalog.dart';
import '../stuodents/course_registration.dart';
import '../stuodents/student_community.dart';
import '../stuodents/Academic_Support.dart';
import '../stuodents/Fee_Management.dart';

class StudentsPageColors {
  static const primary = Color(0xFF304FFE);
  static const serviceCard1 = Color(0xFF4CAF50);
  static const serviceCard2 = Color(0xFF2196F3);
  static const serviceCard3 = Color(0xFFFF9800);
  static const serviceCard4 = Color(0xFFF44336);
  static const serviceCard5 = Color(0xFF9C27B0);
  static const serviceCard6 = Color(0xFF00BCD4);
  static const serviceCard7 = Color(0xFF795548);
  static const serviceCard8 = Color(0xFF3F51B5);
}

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome, Student',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: StudentsPageColors.primary,
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.85,
          children: [
            _buildServiceCard(
              title: 'Course Catalog',
              icon: Icons.library_books_rounded,
              color: StudentsPageColors.serviceCard1,
              page: const CoursesPage(),
            ),
            _buildServiceCard(
              title: 'Class Schedule',
              icon: Icons.schedule_rounded,
              color: StudentsPageColors.serviceCard2,
              page: const SchedulePage(),
            ),
            _buildServiceCard(
              title: 'Academic Grades',
              icon: Icons.assessment_rounded,
              color: StudentsPageColors.serviceCard3,
              page: const GradesPage(),
            ),
            _buildServiceCard(
              title: 'Attendance Tracker',
              icon: Icons.fact_check_rounded,
              color: StudentsPageColors.serviceCard4,
              page: const WarningsPage(),
            ),
            _buildServiceCard(
              title: 'Course Registration',
              icon: Icons.app_registration_rounded,
              color: StudentsPageColors.serviceCard5,
              page: const RegistrationPage(),
            ),
            _buildServiceCard(
              title: 'Student Community',
              icon: Icons.forum_rounded,
              color: StudentsPageColors.serviceCard6,
              page: const ForumsPage(),
            ),
            _buildServiceCard(
              title: 'Academic Support',
              icon: Icons.support_agent_rounded,
              color: StudentsPageColors.serviceCard7,
              page: const SupportPage(),
            ),
            _buildServiceCard(
              title: 'Fee Management',
              icon: Icons.payment_rounded,
              color: StudentsPageColors.serviceCard8,
              page: const PaymentPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      shadowColor: color.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Get.to(() => page),
        splashColor: color.withOpacity(0.1),
        highlightColor: color.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.15), color.withOpacity(0.25)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 28, color: color),
                  ),
                  const SizedBox(),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2A3256),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
