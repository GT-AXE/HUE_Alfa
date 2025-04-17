import 'package:flutter/material.dart';

class AicsDepartmentsPage extends StatelessWidget {
  const AicsDepartmentsPage({super.key});

  final List<String> departments = const [
    'Artificial Intelligence',
    'Data Science',
    'Cyber Security',
    'Computer Vision',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AICS Departments')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.account_tree),
              title: Text(departments[index]),
            ),
          );
        },
      ),
    );
  }
}
