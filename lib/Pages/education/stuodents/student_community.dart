import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumsPage extends StatelessWidget {
  const ForumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> forums = [
      'General Discussion',
      'Study Groups',
      'Events & Activities',
      'Project Help',
      'Internship Opportunities',
      'Tech Talks',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Community'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: forums.length,
        separatorBuilder: (_, __) => const Divider(height: 20),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Icon(Icons.forum, color: Colors.indigo),
            ),
            title: Text(
              forums[index],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {
              Get.snackbar(
                'Access Denied',
                'This forum is under development.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.indigo.withOpacity(0.1),
                colorText: Colors.black87,
                duration: const Duration(seconds: 2),
              );
            },
          );
        },
      ),
    );
  }
}
