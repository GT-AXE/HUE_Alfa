import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart'; 

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن التطبيق'),
        backgroundColor: AppColors.primary, 
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 20),
            _buildCard(
              Icons.info,
              'معلومات التطبيق',
              [
                _buildRow('الإصدار', 'BETA 0.0.1'),
                _buildRow('التاريخ', '2024/10/10'),
                _buildRow('الحالة', 'قيد التطوير'),
                _buildRow('المطور', 'AXE Team'),
              ],
            ),
            _buildCard(
              Icons.list,
              'المميزات',
              [
                'إدارة الجداول الدراسية',
                'تسليم الواجبات الإلكترونية',
                'التواصل مع أعضاء هيئة التدريس',
                'الوصول للموارد التعليمية',
              ].map((e) => _buildBullet(e)).toList(),
            ),
            _buildCard(
              Icons.contact_page,
              'التواصل',
              [
                _buildContact(Icons.email, 'support@hueapp.com'),
                _buildContact(Icons.language, 'www.hueapp.com'),
                _buildContact(Icons.phone, '+964 123 456 789'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: AppColors.primary), 
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildContact(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 15),
          Text(text, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
