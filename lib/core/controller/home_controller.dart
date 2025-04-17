import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/Pages/home/home.dart';
import 'package:hue/Pages/universities/universities_/universities_page.dart';
import 'package:hue/Pages/education/doctors.dart';
import 'package:hue/Pages/education/students.dart';
import 'package:hue/Pages/settings/settings.dart';
import 'package:hue/Pages/academics/submissions.dart';
import 'package:hue/Pages/chat/chat.dart';
import 'package:hue/Pages/staff/staff.dart';
import 'package:hue/core/models/role.dart';
import '../controllers/role_manager.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> pages = [
    HomePage(),
    UniversitiesPage(),
    DoctorsPage(),
    StudentsPage(),
    SettingsPage(),
    SubmissionsPage(),
    ChatPage(),
    StaffPage(userRole: Role.hr), 
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
