import 'package:flutter/material.dart';

class WarningsPage extends StatelessWidget {
  const WarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> attendance = [
      {'date': '2025-04-10', 'status': 'Present', 'course': 'Math 101'},
      {'date': '2025-04-11', 'status': 'Absent', 'course': 'Science 101'},
      {'date': '2025-04-12', 'status': 'Present', 'course': 'Literature 101'},
      {'date': '2025-04-13', 'status': 'Present', 'course': 'History 101'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Your Attendance Record:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Attendance List
            Expanded(
              child: ListView.builder(
                itemCount: attendance.length,
                itemBuilder: (context, index) {
                  return _buildAttendanceCard(
                    attendance[index]['date']!,
                    attendance[index]['status']!,
                    attendance[index]['course']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(String date, String status, String course) {
    Color statusColor = status == 'Present' ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Optional: Navigate to attendance details or edit page
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Course and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$course - $date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              // Optional: Edit or Mark Attendance button
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Optional: Navigate to edit or update attendance
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
