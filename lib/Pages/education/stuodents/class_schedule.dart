import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> schedule = [
      {'day': 'Monday', 'time': '8:00 AM - 10:00 AM', 'subject': 'Math 101'},
      {'day': 'Monday', 'time': '10:30 AM - 12:30 PM', 'subject': 'Science 101'},
      {'day': 'Tuesday', 'time': '8:00 AM - 10:00 AM', 'subject': 'History 101'},
      {'day': 'Wednesday', 'time': '9:00 AM - 11:00 AM', 'subject': 'Literature 101'},
      {'day': 'Friday', 'time': '11:00 AM - 1:00 PM', 'subject': 'Computer Science 101'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Weekly Schedule:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: schedule.length,
                itemBuilder: (context, index) {
                  return _buildScheduleCard(
                    schedule[index]['day']!,
                    schedule[index]['time']!,
                    schedule[index]['subject']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(String day, String time, String subject) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Optional: Navigate to class details or edit page
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$day - $time',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subject,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Optional: Navigate to a page to edit the schedule
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
