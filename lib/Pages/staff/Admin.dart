import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8FAFD),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          dashboard(),
          student(),
          recent(),
          Settings(),
          Analytics(),
          Messages(),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _buildFloatingButton(),
      drawer: _buildSideDrawer(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        _getAppBarTitle(),
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      actions: [
        IconButton(
          icon: Badge(
            smallSize: 8,
            child: const Icon(Iconsax.notification, size: 24),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
////hide bottom navigation bar

  // Widget _buildBottomNavBar() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.2),
  //           blurRadius: 20,
  //           offset: const Offset(0, -5),
  //         ),
  //       ],
  //     ),
  //     child: ClipRRect(
  //       borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //       child: BottomNavigationBar(
  //         currentIndex: _currentIndex,
  //         onTap: (index) => setState(() => _currentIndex = index),
  //         type: BottomNavigationBarType.fixed,
  //         backgroundColor: Colors.white,
  //         selectedItemColor: const Color(0xFF3D5CFF),
  //         unselectedItemColor: Colors.grey,
  //         selectedLabelStyle: GoogleFonts.poppins(fontSize: 11),
  //         unselectedLabelStyle: GoogleFonts.poppins(fontSize: 11),
  //         items: const [
  //           BottomNavigationBarItem(
  //             icon: Icon(Iconsax.home),
  //             label: 'Home',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Iconsax.chart_2),
  //             label: 'Analytics',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Iconsax.message),
  //             label: 'Messages',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Iconsax.setting_2),
  //             label: 'Settings',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () => _showQuickActions(context),
      backgroundColor: const Color(0xFF3D5CFF),
      elevation: 5,
      child: const Icon(Iconsax.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildSideDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3D5CFF), Color(0xFF5B8DFF)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Cyber_Security.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome DEV',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'DEV@horus.edu.eg',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                //   decoration: BoxDecoration(
                //     color: Colors.white.withOpacity(0.2),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Text(
                //     'Super Admin',
                //     style: GoogleFonts.poppins(
                //       color: Colors.white,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          _drawerItem(Iconsax.home, 'Dashboard', 0),
          _drawerItem(Iconsax.profile_2user, 'Students', null),
          _drawerItem(Iconsax.calendar, 'Schedule', null),
          const Divider(indent: 100, endIndent: 100, color: Color.fromARGB(255, 0, 140, 255)),
          _drawerItem(Iconsax.setting_2, 'Settings', 3),
          _drawerItem(Iconsax.logout, 'Sign Out', null),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int? index) {
    return ListTile(
      leading: Icon(icon, color: _currentIndex == index ? const Color(0xFF3D5CFF) : Colors.grey[700]),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: _currentIndex == index ? FontWeight.w600 : FontWeight.normal,
          color: _currentIndex == index ? const Color(0xFF3D5CFF) : Colors.grey[800],
        ),
      ),
      onTap: () {
        if (index != null) setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
    );
  }
 ///// Show Quick Actions
void _showQuickActions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Quick Actions',
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10,  
                children: [
                  _quickAction(Iconsax.profile_add, 'Add Student', Colors.blue),
                  _quickAction(Iconsax.teacher, 'Add Faculty', Colors.green),
                  _quickAction(Iconsax.book, 'New Course', Colors.orange),
                  _quickAction(Iconsax.calendar_add, 'Add Event', Colors.purple),
                  _quickAction(Iconsax.note_add, 'Create Exam', Colors.red),
                  _quickAction(Iconsax.document_upload, 'Upload', Colors.teal),


                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}


  Widget _quickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0: return 'Dashboard';
      case 1: return 'Analytics';
      case 2: return 'Messages';
      case 3: return 'Settings';
      default: return 'Admin Panel';
    }
  }
}


class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // const SizedBox(height: 25),
          // Text(
          //   'Quick Access',
          //   style: GoogleFonts.poppins(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          // const SizedBox(height: 15),
          // GridView.count(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   crossAxisCount: 4,
          //   childAspectRatio: 0.9,
          //   children: [
          //     _quickAccessItem(Iconsax.profile_2user, 'Students', Colors.blue),
          //     _quickAccessItem(Iconsax.teacher, 'Faculty', Colors.green),
          //     _quickAccessItem(Iconsax.book, 'Courses', Colors.orange),
          //     _quickAccessItem(Iconsax.calendar, 'Schedule', Colors.purple),
          //     _quickAccessItem(Iconsax.note, 'Exams', Colors.red),
          //     _quickAccessItem(Iconsax.document, 'Reports', Colors.teal),
          //     _quickAccessItem(Iconsax.setting_2, 'Settings', Colors.indigo),
          //     _quickAccessItem(Iconsax.more, 'More', Colors.grey),
          //   ],
          // ),
          const SizedBox(height: 25),
          Text(
            'Statistics',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _statCard('12,456', 'Students', Iconsax.profile_2user, Colors.blue, '4.5%'),
                const SizedBox(width: 12),
                _statCard('1,245', 'Faculty', Iconsax.teacher, Colors.green, '2.1%'),
                const SizedBox(width: 12),
                _statCard('356', 'Courses', Iconsax.book, Colors.orange, '7.8%'),
                const SizedBox(width: 12),
                _statCard('24', 'Departments', Iconsax.building_3, Colors.purple, '1.2%'),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 17, 0, 255),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _activityItem(Iconsax.profile_add, 'New student registered', '10 min ago', Colors.blue),
          _activityItem(Iconsax.edit, 'Course CS101 updated', '25 min ago', Colors.green),
          _activityItem(Iconsax.calendar, 'Exam schedule published', '1 hour ago', Colors.orange),
          _activityItem(Iconsax.message, 'New message from faculty', '2 hours ago', Colors.purple),
          _activityItem(Iconsax.notification, 'New notification', '3 hours ago', Colors.red),
          _activityItem(Iconsax.document, 'New report generated', '5 hours ago', Colors.teal),
          _activityItem(Iconsax.support, 'Support ticket resolved', '1 day ago', Colors.indigo),
          _activityItem(Iconsax.setting_2, 'Settings updated', '2 days ago', Colors.grey),],
      ),
    );
  }

  Widget _quickAccessItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color color, String percent) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 200, 200, 200),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              const Icon(Iconsax.arrow_up_1, color: Colors.green, size: 16),
              Text(
                ' $percent',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(IconData icon, String title, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 245),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Iconsax.arrow_right_3, size: 18),
        ],
      ),
    );
  }
}

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Analytics',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Messages',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}
class student extends StatelessWidget {
  const student({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Student',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}
class recent extends StatelessWidget {
  const recent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Recent',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}