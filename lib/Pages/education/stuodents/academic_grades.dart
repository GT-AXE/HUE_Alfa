import 'package:flutter/material.dart';

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildBody(),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('My Grades',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade700,
                Colors.purple.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  SliverList _buildBody() {
    final grades = _getSampleGradesData();
    final gpa = _calculateGPA(grades);

    return SliverList(
      delegate: SliverChildListDelegate([
        _buildGPAInfo(gpa),
        const SizedBox(height: 16),
        ...grades.map((course) => _buildGradeCard(course)).toList(),
        const SizedBox(height: 40),
      ]),
    );
  }

  Widget _buildGPAInfo(double gpa) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getGPAColor(gpa).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star,
                  color: _getGPAColor(gpa), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current GPA',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14)),
                  Text(gpa.toStringAsFixed(2),
                      style: TextStyle(
                          color: _getGPAColor(gpa),
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Chip(
              backgroundColor: Colors.indigo.withOpacity(0.1),
              label: Text(_getGPAStatus(gpa),
                  style: TextStyle(color: Colors.indigo.shade700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeCard(CourseGrade course) {
    final gradeInfo = _getGradeInfo(course.grade);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: gradeInfo.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.school,
                      color: gradeInfo.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('${course.creditHours} Credit Hours',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(course.grade,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: gradeInfo.color)),
                    Text(gradeInfo.description,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<CourseGrade> _getSampleGradesData() {
    return [
      CourseGrade('Mathematics', 'A', 4),
      CourseGrade('Physics', 'B+', 3),
      CourseGrade('Computer Science', 'A-', 4),
      CourseGrade('Chemistry', 'B', 3),
      CourseGrade('Literature', 'C+', 2),
      CourseGrade('History', 'A', 2),
    ];
  }

  double _calculateGPA(List<CourseGrade> courses) {
    double totalPoints = 0;
    int totalCredits = 0;
    
    for (var course in courses) {
      final gradeValue = _gradeToValue(course.grade);
      totalPoints += gradeValue * course.creditHours;
      totalCredits += course.creditHours;
    }
    
    return totalPoints / totalCredits;
  }

  double _gradeToValue(String grade) {
    switch (grade) {
      case 'A': return 4.0;
      case 'A-': return 3.7;
      case 'B+': return 3.3;
      case 'B': return 3.0;
      case 'B-': return 2.7;
      case 'C+': return 2.3;
      case 'C': return 2.0;
      case 'C-': return 1.7;
      case 'D+': return 1.3;
      case 'D': return 1.0;
      default: return 0.0;
    }
  }

  Color _getGPAColor(double gpa) {
    if (gpa >= 3.5) return Colors.green.shade600;
    if (gpa >= 2.5) return Colors.blue.shade600;
    if (gpa >= 1.5) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  String _getGPAStatus(double gpa) {
    if (gpa >= 3.5) return 'Excellent';
    if (gpa >= 2.5) return 'Good';
    if (gpa >= 1.5) return 'Average';
    return 'Needs Improvement';
  }

  GradeInfo _getGradeInfo(String grade) {
    final letter = grade[0];
    final isPlus = grade.length > 1 && grade[1] == '+';
    final isMinus = grade.length > 1 && grade[1] == '-';
    
    if (letter == 'A') {
      return GradeInfo(
        color: Colors.green.shade600,
        description: isPlus ? 'Excellent' : isMinus ? 'Very Good' : 'Outstanding',
      );
    } else if (letter == 'B') {
      return GradeInfo(
        color: Colors.blue.shade600,
        description: isPlus ? 'Good' : isMinus ? 'Above Average' : 'Good',
      );
    } else if (letter == 'C') {
      return GradeInfo(
        color: Colors.orange.shade600,
        description: isPlus ? 'Average' : isMinus ? 'Below Average' : 'Average',
      );
    } else {
      return GradeInfo(
        color: Colors.red.shade600,
        description: 'Needs Improvement',
      );
    }
  }
}

class CourseGrade {
  final String name;
  final String grade;
  final int creditHours;

  CourseGrade(this.name, this.grade, this.creditHours);
}

class GradeInfo {
  final Color color;
  final String description;

  GradeInfo({required this.color, required this.description});
}