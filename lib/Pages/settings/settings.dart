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
  String selectedLanguage = 'English';  // متغير لتخزين اللغة المحددة

  @override
  void initState() {
    super.initState();
    _loadPreferences();  // تحميل التفضيلات عند بدء الصفحة
  }

  // دالة لتحميل تفضيلات المستخدم من SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';  // استرجاع اللغة المحددة
    });
  }

  // دالة لحفظ اللغة المحددة في SharedPreferences
  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);  // حفظ اللغة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              // إعدادات اللغة
              _buildSettingItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: selectedLanguage,
                onTap: () => _showLanguageDialog(context),
              ),
              // إعدادات الحساب
              _buildSettingItem(
                icon: Icons.account_circle,
                title: 'Account Settings',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                ),
              ),
              // حول التطبيق
              _buildSettingItem(
                icon: Icons.info_outline,
                title: 'About Application',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                ),
              ),
              // لوحة الإدارة
              _buildSettingItem(
                icon: Icons.admin_panel_settings,
                title: 'Admin Panel',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لبناء عناصر الإعدادات
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent, size: 28),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: GoogleFonts.poppins(fontSize: 13)) : null,
      trailing: trailing ?? Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.blueAccent),
      onTap: onTap,
    );
  }

  // دالة لعرض حوار اختيار اللغة
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Arabic'].map((language) => RadioListTile(
            title: Text(language),
            value: language,
            groupValue: selectedLanguage,
            activeColor: Colors.blueAccent,
            onChanged: (value) {
              setState(() => selectedLanguage = value.toString());  // تغيير اللغة المحددة
              _saveLanguage(value.toString());  // حفظ اللغة المحددة
              Navigator.pop(context);  // إغلاق الحوار بعد التحديد
            },
          )).toList(),
        ),
      ),
    );
  }
}
