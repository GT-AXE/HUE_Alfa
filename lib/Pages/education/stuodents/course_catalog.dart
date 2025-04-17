import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> courses = [
      {'title': 'Math 101', 'description': 'Basic Math Concepts', 'image': 'assets/images/Cyber_Security.png'},
      {'title': 'Science 101', 'description': 'Introduction to Science', 'image': 'assets/images/Cyber_Security.png'},
      {'title': 'History 101', 'description': 'World History Basics', 'image': 'assets/images/Cyber_Security.png'},
      {'title': 'Literature 101', 'description': 'Study of Classic Literature', 'image': 'assets/images/Cyber_Security.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Catalog'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Courses',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
              },
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return _buildCourseCard(
                    courses[index]['title']!,
                    courses[index]['description']!,
                    courses[index]['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(String title, String description, String image) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: InkWell(
        // onTap: () {
        //    Navigate to course details page or registration page
        //    Example: Get.to(() => CourseDetailsPage());
        // },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // Navigate to detailed page
                  // Example: Get.to(() => CourseDetailsPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
