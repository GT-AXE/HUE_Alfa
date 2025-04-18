import 'package:flutter/material.dart';

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> grades = [
      {'course': 'Mathematics', 'grade': 'A'},
      {'course': 'Physics', 'grade': 'B+'},
      {'course': 'Computer Science', 'grade': 'A-'},
      {'course': 'Chemistry', 'grade': 'B'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Grades'),
        backgroundColor: Colors.indigo.shade700,
        centerTitle: true,
        elevation: 4,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.school_outlined),
          )
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '📘 Your Grades:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: grades.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildGradeCard(
                      course: grades[index]['course']!,
                      grade: grades[index]['grade']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeCard({required String course, required String grade}) {
    Color gradeColor = _getGradeColor(grade);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: Colors.indigo.shade100,
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.indigo),
        title: Text(
          course,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: gradeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            grade,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: gradeColor,
            ),
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return Colors.green;
    if (grade.startsWith('B')) return Colors.orange;
    return Colors.red;
  }
}
