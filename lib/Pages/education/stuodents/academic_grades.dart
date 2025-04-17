import 'package:flutter/material.dart';

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // نموذج للدرجات الأكاديمية
    List<Map<String, String>> grades = [
      {'course': 'Mathematics', 'grade': 'A'},
      {'course': 'Physics', 'grade': 'B+'},
      {'course': 'Computer Science', 'grade': 'A-'},
      {'course': 'Chemistry', 'grade': 'B'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Grades'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Grades:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // جدول الدرجات
            Expanded(
              child: ListView.builder(
                itemCount: grades.length,
                itemBuilder: (context, index) {
                  return _buildGradeCard(
                    grades[index]['course']!,
                    grades[index]['grade']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeCard(String course, String grade) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              course,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              grade,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
