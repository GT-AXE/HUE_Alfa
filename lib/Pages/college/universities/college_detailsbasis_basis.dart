// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import '../departments/ai_cs.dart';
import '../departments/Fine Arts.dart';
import '../departments/Physical Therapy.dart';
import '../departments/Human Medicine.dart';
import '../departments/Pharmacy.dart';
import '../departments/Linguistics.dart';
import '../departments/Applied Health Sciences.dart';
import '../departments/Business Admin.dart';
import '../departments/Dentistry.dart';
import '../departments/Engineering.dart';

class CollegeDetailsPage extends StatelessWidget {
  final Map<String, String> college;
  const CollegeDetailsPage({super.key, required this.college});

  void _navigateToDepartments(BuildContext context) {
    final title = college['title'];
    Widget page;

    switch (title) {
      case 'AICS':
        page = const AicsDepartmentsPage();
        break;
      default:
        page = Scaffold(
          appBar: AppBar(title: const Text('Departments')),
          body: const Center(child: Text('No departments found')),
        );
    }

    Navigator.push(
      context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(college['title']!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CollegeDetailsColors.backgroundGradientStart,
                  CollegeDetailsColors.backgroundGradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  Hero(
                    tag: college['title']!,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: CollegeDetailsColors.imageShadow,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          college['image']!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.school, size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    college['title']!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: CollegeDetailsColors.titleText,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Explore all departments under this college and find your path.",
                    style: TextStyle(
                      fontSize: 16,
                      color: CollegeDetailsColors.subtitleText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: CollegeDetailsColors.buttonPrimaryBackground,
                      foregroundColor: CollegeDetailsColors.buttonPrimaryForeground,
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _navigateToDepartments(context),
                    icon: const Icon(Icons.list),
                    label: const Text(
                      "View Departments",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: CollegeDetailsColors.buttonSecondaryBackground,
                      foregroundColor: CollegeDetailsColors.buttonSecondaryForeground,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('${college['title']} Info'),
                          content: const Text(
                            "Here you can later show full info about the college like programs, credits, admission, and contact info.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_outline),
                    label: const Text(
                      "College Info",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
