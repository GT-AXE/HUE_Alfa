import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  final RxInt _hoverIndex = (-1).obs;

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

  void setHoverIndex(int index) => _hoverIndex.value = index;
  int get hoverIndex => _hoverIndex.value;
}

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.scaffoldBackground,
      appBar: CustomAppBar(),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IndexedStack(
              key: ValueKey<int>(controller.selectedIndex.value),
              index: controller.selectedIndex.value,
              children: controller.pages,
            ),
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
      elevation: 0,
      title: Image.asset(
        Assets.imagesLogoBlue,
        width: 120,
        height: 50,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(Icons.login, color: Colors.yellow[700], size: 28),
            onPressed: () => Get.offAll(Login()),
            tooltip: 'تسجيل الدخول',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 0, 0, 0),
            border: Border(
              top: BorderSide(color: const Color.fromARGB(0, 255, 255, 255), width: 0.8),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(0, 129, 129, 129),
            elevation: 0,
            selectedItemColor: Colors.amberAccent,
            unselectedItemColor: Colors.blueAccent,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: [
              _buildItem(CupertinoIcons.home, "home", isSelected: controller.selectedIndex.value == 0),
              _buildItem(CupertinoIcons.building_2_fill, "college", isSelected: controller.selectedIndex.value == 1),
              _buildItem(CupertinoIcons.person_2_fill, "doctors", isSelected: controller.selectedIndex.value == 2),
              _buildItem(CupertinoIcons.person_crop_rectangle, "students", isSelected: controller.selectedIndex.value == 3),
              _buildItem(CupertinoIcons.settings, "settings", isSelected: controller.selectedIndex.value == 4),
              _buildItem(CupertinoIcons.doc_plaintext, "المهام", isSelected: controller.selectedIndex.value == 5),
              _buildItem(CupertinoIcons.chat_bubble_2, "chat", isSelected: controller.selectedIndex.value == 6),
              _buildItem(CupertinoIcons.briefcase_fill, "staff", isSelected: controller.selectedIndex.value == 7),
            ],
          ),
        ));
  }

  BottomNavigationBarItem _buildItem(IconData icon, String label, {required bool isSelected}) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: isSelected ? 26 : 22),
      label: label,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> ads = [
    {
      'images': Assets.imagesHUE,
      'title': 'فعاليات الجامعة',
      'description': 'شارك في الفعاليات القادمة'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'المنح الدراسية',
      'description': 'فرص منح للطلاب المتفوقين'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'ورش العمل',
      'description': 'تطوير مهاراتك مع خبرائنا'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'المؤتمرات',
      'description': 'أحدث الأبحاث والاكتشافات'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'النتائج',
      'description': 'اعلان نتائج الفصل الدراسي'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'التوظيف',
      'description': 'فرص عمل للخريجين'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'الأنشطة',
      'description': 'أنشطة طلابية متنوعة'
    },
    {
      'images': Assets.imagesHUE,
      'title': 'الدورات',
      'description': 'تنمية مهاراتك التعليمية'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HomeColors.scaffoldBackground.withOpacity(0.8),
              HomeColors.scaffoldBackground.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(context),
            Expanded(child: _buildAdGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرحباً بك في HUE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: HomeColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'استكشف آخر الأخبار والفعاليات',
            style: TextStyle(
              fontSize: 16,
              color: HomeColors.secondaryText,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAdGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: ads.length,
        itemBuilder: (context, index) => _buildAdCard(ads[index]),
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(ad['images'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                ad['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HomeColors.primaryText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                ad['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: HomeColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
