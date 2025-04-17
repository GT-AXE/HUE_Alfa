import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'package:hue/core/utils/assets.dart'; 

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the App'),
        backgroundColor: AppColors.primary, 
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(Assets.imagesLogo),
              backgroundColor: Color.fromARGB(255, 0, 0, 0), 
            ),
            const SizedBox(height: 20),
            _buildCard(
              Icons.info,
              'App Information',
              [
                _buildRow('Version', 'ALFA 0.0.1'),
                _buildRow('Date', '2024/10/10'),
                _buildRow('Status', 'Under Development'),
                _buildRow('Developer', 'AXE'),
              ],
            ),
            _buildCard(
              Icons.list,
              'Features',
              [
                'Schedule Management',
                'Electronic Assignment Submission',
                'Communication with Faculty Members',
                'Access to Educational Resources',
              ].map((e) => _buildBullet(e)).toList(),
            ),
            _buildCard(
              Icons.contact_page,
              'Contact',
              [
                _buildContact(Icons.email, 'dev_axe@horus.edu.eg'),
                _buildContact(Icons.phone, '+201012345678'),
                _buildContact(Icons.wechat_sharp, 'Through the app'),
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
          Text(value, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
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
          Text(text, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
        ],
      ),
    );
  }
}
