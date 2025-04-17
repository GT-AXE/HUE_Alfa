// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/core/utils/assets.dart';
import 'package:hue/core/models/role.dart';
import 'package:hue/core/controllers/role_manager.dart';
import 'package:hue/Pages/staff/staff.dart';
import '../auth/login.dart';
import '../college/universities/universities_page.dart';
import '../education/doctors/doctors.dart';
import '../education/stuodents/students.dart';
import '../settings/settings.dart';
import '../academics/submissions.dart';
import '../chat/chat.dart';
import 'package:hue/core/utils/app_colors.dart';

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

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          )),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HomeColors.appBarColor,
      elevation: 10,
      title: Image.asset(Assets.imagesLogoBlue, width: 120, height: 50),
      actions: [
        IconButton(
          icon: Icon(Icons.login, color: Colors.yellow),
          onPressed: () => Get.offAll(Login()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changePage,
              selectedItemColor: HomeColors.bottomNavBarSelected,
              unselectedItemColor: HomeColors.bottomNavBarUnselected,
              items: [
                _buildBottomNavItem(Icons.home, 'Home'),
                _buildBottomNavItem(Icons.school, 'Colleges'),
                _buildBottomNavItem(Icons.diversity_2_outlined, 'Doctors'),
                _buildBottomNavItem(Icons.people, 'Students'),
                _buildBottomNavItem(Icons.settings, 'Settings'),
                _buildBottomNavItem(Icons.assignment, 'Submissions'),
                _buildBottomNavItem(Icons.chat, 'Chat'),
                _buildBottomNavItem(Icons.work, 'Staff'),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ));
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> ads = [
    {'images': Assets.imagesHUE, 'title': '1', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '2', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '3', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '4', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '5', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '6', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '7', 'description': ''},
    {'images': Assets.imagesHUE, 'title': '8', 'description': ''},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesHUE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(child: _buildAdGrid(context)),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildAdGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, 
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: ads.length,
      itemBuilder: (context, index) => _buildAdItem(ads[index]),
    );
  }

  Widget _buildAdItem(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => _onAdTap(ad), 
      child: Card(
        elevation: 8, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), 
        shadowColor: HomeColors.appBarColor.withOpacity(0.4),
        color: HomeColors.adCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(ad['images'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                ad['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: HomeColors.adCardTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                ad['description'],
                style: TextStyle(
                  fontSize: 12,
                  color: HomeColors.adCardTextColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, 
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdTap(Map<String, dynamic> ad) {
    print('تم النقر على الإعلان: ${ad['title']}');
  }
}
