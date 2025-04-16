// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'detail_pages.dart'; // تأكد من أنك أنشأت هذا الملف يحتوي على الصفحات الثانوية

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Portal',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: StudentsPageColors.primary, // استخدام اللون الأساسي
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Academic Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: StudentsPageColors.sectionTitle, // استخدام لون العنوان
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85,
                children: [
                  _buildServiceCard(
                    context,
                    title: 'Course Catalog',
                    icon: Icons.library_books_rounded,
                    color: StudentsPageColors.serviceCard1,
                    page: const CoursesPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Class Schedule',
                    icon: Icons.schedule_rounded,
                    color: StudentsPageColors.serviceCard2,
                    page: const SchedulePage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Academic Grades',
                    icon: Icons.assessment_rounded,
                    color: StudentsPageColors.serviceCard3,
                    page: const GradesPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Attendance Tracker',
                    icon: Icons.fact_check_rounded,
                    color: StudentsPageColors.serviceCard4,
                    page: const WarningsPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Course Registration',
                    icon: Icons.app_registration_rounded,
                    color: StudentsPageColors.serviceCard5,
                    page: const RegistrationPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Student Community',
                    icon: Icons.forum_rounded,
                    color: StudentsPageColors.serviceCard6,
                    page: const ForumsPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Academic Support',
                    icon: Icons.support_agent_rounded,
                    color: StudentsPageColors.serviceCard7,
                    page: const SupportPage(),
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Fee Management',
                    icon: Icons.payment_rounded,
                    color: StudentsPageColors.serviceCard8,
                    page: const PaymentPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
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
        onTap: () => _navigateWithTransition(context, page),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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

  void _navigateWithTransition(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
                  .animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
