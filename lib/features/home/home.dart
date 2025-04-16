import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استبدال setState بـ GetX
import 'package:hue/core/utils/assets.dart';
import 'package:hue/staff/roles.dart';
import 'package:hue/staff/staff.dart';
import '../auth/login.dart';
import '../college/Colleges.dart';
import '../education/doctors.dart';
import '../education/students.dart';
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
    StaffPage(userRole: Role.admin), // ← أضفنا صفحة الموظفين
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
      backgroundColor: HomeColors.appBarColor, // استخدام اللون المحدد لـ AppBar
      elevation: 10,
      title: Image.asset(Assets.imagesLogoBlue, width: 120, height: 50),
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Colors.yellow),
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
          margin: EdgeInsets.all(10),
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
              selectedItemColor: HomeColors.bottomNavBarSelected, // اللون عند التحديد
              unselectedItemColor: HomeColors.bottomNavBarUnselected, // اللون عند عدم التحديد
              items: [
                _buildBottomNavItem(Icons.home, 'Home'),
                _buildBottomNavItem(Icons.school, 'Colleges'),
                _buildBottomNavItem(Icons.diversity_2_outlined, 'Doctors'),
                _buildBottomNavItem(Icons.people, 'Students'),
                _buildBottomNavItem(Icons.settings, 'Settings'),
                _buildBottomNavItem(Icons.assignment, 'Submissions'),
                _buildBottomNavItem(Icons.chat, 'Chat'),
                _buildBottomNavItem(Icons.work, 'Staff'), // زر الموظفين الجديد
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

// تحسين التصميم بإضافة تأثيرات للأزرار والإعلانات
class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> ads = [
    {'images': Assets.imagesAICS, 'title': 'منح دراسية', 'description': 'تقديم الآن للالتحاق بالمنح الدراسية الدولية'},
    {'images': Assets.imagesAICS, 'title': 'دورات صيفية', 'description': 'سجل في برامجنا الصيفية المكثفة'},
    {'images': Assets.imagesAICS, 'title': 'معرض وظائف', 'description': 'شارك في معرض الوظائف السنوي'},
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
              _buildAdBanner(),
              Expanded(child: _buildAdGrid()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      height: 100,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(Assets.imagesLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildAdGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      itemCount: ads.length,
      itemBuilder: (context, index) => _buildAdItem(ads[index]),
    );
  }

  Widget _buildAdItem(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => print('تم النقر على الإعلان: ${ad['title']}'),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: HomeColors.appBarColor, // تغيير اللون الظل إلى لون AppBar
        color: HomeColors.adCardColor, // لون الخلفية الخاص ببطاقة الإعلان
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(ad['images'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(ad['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: HomeColors.adCardTextColor), // استخدام لون النص الخاص بالإعلان
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
