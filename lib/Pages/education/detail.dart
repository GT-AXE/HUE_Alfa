import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Course Catalog',
      content: 'All available courses for current semester',
    );
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Class Schedule',
      content: 'Weekly timetable and class locations',
    );
  }
}

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Academic Grades',
      content: 'Current semester grades and GPA',
    );
  }
}

class WarningsPage extends StatelessWidget {
  const WarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Attendance Warnings',
      content: 'Attendance statistics and warnings',
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Course Registration',
      content: 'Register for next semester courses',
    );
  }
}

class ForumsPage extends StatelessWidget {
  const ForumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Student Forums',
      content: 'Academic discussions and Q&A section',
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Academic Support',
      content: 'Contact academic advisors and support team',
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDetailPage(
      context,
      title: 'Fee Payment',
      content: 'Tuition fees payment gateway',
    );
  }
}

Widget _buildDetailPage(BuildContext context, 
    {required String title, required String content}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF2A3256),
            ),
          ),
        ],
      ),
    ),
  );
}