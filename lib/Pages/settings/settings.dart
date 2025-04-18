import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile.dart';
import 'About.dart';
import 'Admin.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'English';
  bool darkMode = false;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
      darkMode = prefs.getBool('darkMode') ?? false;
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      darkMode = value;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    setState(() {
      notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE4E7EB),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildSectionHeader('التفضيلات العامة'),
                _buildSettingCard(
                  children: [
                    _buildSettingItem(
                      icon: Icons.language,
                      iconColor: Color(0xFF2575FC),
                      title: 'اللغة',
                      subtitle: selectedLanguage,
                      onTap: () => _showLanguageDialog(context),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.dark_mode,
                      iconColor: Color(0xFF6A11CB),
                      title: 'الوضع الليلي',
                      trailing: Switch(
                        value: darkMode,
                        onChanged: _toggleDarkMode,
                        activeColor: Color(0xFF6A11CB),
                        activeTrackColor: Color(0xFF6A11CB).withOpacity(0.3),
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.notifications_active,
                      iconColor: Color(0xFFFF6B6B),
                      title: 'الإشعارات',
                      trailing: Switch(
                        value: notificationsEnabled,
                        onChanged: _toggleNotifications,
                        activeColor: Color(0xFFFF6B6B),
                        activeTrackColor: Color(0xFFFF6B6B).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildSectionHeader('حساب المستخدم'),
                _buildSettingCard(
                  children: [
                    _buildSettingItem(
                      icon: Icons.account_circle,
                      iconColor: Color(0xFF4CAF50),
                      title: 'الملف الشخصي',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.security,
                      iconColor: Color(0xFF9C27B0),
                      title: 'الأمان والخصوصية',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildSectionHeader('حول التطبيق'),
                _buildSettingCard(
                  children: [
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      iconColor: Color(0xFF2196F3),
                      title: 'عن التطبيق',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.star_rate,
                      iconColor: Color(0xFFFFC107),
                      title: 'قيم التطبيق',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.share,
                      iconColor: Color(0xFF00BCD4),
                      title: 'مشاركة التطبيق',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildSectionHeader('الإدارة'),
                _buildSettingCard(
                  children: [
                    _buildSettingItem(
                      icon: Icons.admin_panel_settings,
                      iconColor: Color(0xFF607D8B),
                      title: 'لوحة التحكم',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboard()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'الإصدار 1.0.0',
                    style: GoogleFonts.tajawal(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: GoogleFonts.tajawal(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: GoogleFonts.tajawal(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.tajawal(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      minVerticalPadding: 0,
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر اللغة',
                style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF2575FC),
                ),
              ),
              SizedBox(height: 20),
              ...['English', 'العربية'].map((language) => RadioListTile(
                    title: Text(
                      language,
                      style: GoogleFonts.tajawal(fontSize: 16),
                    ),
                    value: language,
                    groupValue: selectedLanguage,
                    activeColor: Color(0xFF6A11CB),
                    onChanged: (value) {
                      setState(() => selectedLanguage = value.toString());
                      _saveLanguage(value.toString());
                      Navigator.pop(context);
                    },
                  )),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'إلغاء',
                  style: GoogleFonts.tajawal(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}