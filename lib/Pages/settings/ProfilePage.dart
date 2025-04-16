// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;  // لتخزين الصورة التي يختارها المستخدم
  final picker = ImagePicker();  // لاختيار الصور من الكاميرا أو المعرض
  final String _defaultAsset = 'assets/images/default_profile.png';  // الصورة الافتراضية في حالة عدم وجود صورة للمستخدم

  // دالة لاختيار الصورة من الكاميرا أو المعرض
  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);  // اختيار الصورة من المصدر المحدد
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);  // تخزين الصورة التي تم اختيارها
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to get image: ${e.toString()}');  // في حال حدوث خطأ
    }
  }

  // دالة لعرض رسالة خطأ عند فشل اختيار الصورة
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // دالة لعرض حوار لتأكيد تسجيل الخروج
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),  // إغلاق الحوار
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // تنفيذ منطق تسجيل الخروج هنا
              Navigator.pop(context);  // إغلاق الحوار بعد الخروج
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // صورة الملف الشخصي مع زر تعديل الصورة
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null
                        ? FileImage(_image!)  // إذا كانت الصورة موجودة
                        : AssetImage(_defaultAsset) as ImageProvider,  // الصورة الافتراضية
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () => _showImageSourceDialog(),  // فتح حوار اختيار المصدر
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildProfileInfo(),  // عرض معلومات الملف الشخصي
              SizedBox(height: 30),
              _buildActionButtons(),  // أزرار الإجراءات
              SizedBox(height: 15),
              _buildSupportButton(),  // زر الدعم
            ],
          ),
        ),
      ),
    );
  }

  // دالة لعرض معلومات الملف الشخصي
  Widget _buildProfileInfo() {
    return Column(
      children: [
        Text(
          'AXE',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 8),
        _buildInfoItem('AXE@horus.edu.eg'),
        _buildInfoItem('01095282897'),
        _buildInfoItem('Egypt'),
      ],
    );
  }

  // دالة لعرض معلومات الملف الشخصي بشكل منظم
  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // دالة لعرض الأزرار الخاصة بالإجراءات مثل تغيير كلمة المرور وتسجيل الخروج
  Widget _buildActionButtons() {
    return Column(
      children: [
        Divider(thickness: 1),
        _buildListTile(
          icon: Icons.lock,
          title: 'Change Password',
          color: Colors.blueAccent,
          onTap: () => _navigateToChangePassword(),
        ),
        _buildListTile(
          icon: Icons.logout,
          title: 'Logout',
          color: Colors.red,
          onTap: _showLogoutDialog,
        ),
        Divider(thickness: 1),
      ],
    );
  }

  // دالة لعرض الـ ListTile (عنصر القائمة) مع أيقونة ونص
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: color),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 4),
    );
  }

  // دالة لعرض زر "اتصل بالدعم"
  Widget _buildSupportButton() {
    return ElevatedButton.icon(
      onPressed: () => _contactSupport(),
      icon: Icon(Icons.contact_support),
      label: Text('Contact Support'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // دالة لفتح حوار لاختيار مصدر الصورة (الكاميرا أو المعرض)
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);  // إغلاق الحوار
                _getImage(ImageSource.camera);  // اختيار الصورة من الكاميرا
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);  // إغلاق الحوار
                _getImage(ImageSource.gallery);  // اختيار الصورة من المعرض
              },
            ),
          ],
        ),
      ),
    );
  }

  // دالة للتنقل إلى صفحة تغيير كلمة المرور
  void _navigateToChangePassword() {
    // تنفيذ التنقل إلى صفحة تغيير كلمة المرور هنا
  }

  // دالة للتواصل مع الدعم الفني
  void _contactSupport() {
    // تنفيذ وظيفة الاتصال بالدعم الفني هنا
  }
}
