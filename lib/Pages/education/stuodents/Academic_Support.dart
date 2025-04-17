import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> supportServices = [
      {'service': 'Tutoring Sessions', 'description': 'One-on-one tutoring support.'},
      {'service': 'Academic Counseling', 'description': 'Advice on courses and study plans.'},
      {'service': 'Career Guidance', 'description': 'Help with career planning and development.'},
      {'service': 'Research Assistance', 'description': 'Support for academic research.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Support'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Services:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // List of services
            Expanded(
              child: ListView.builder(
                itemCount: supportServices.length,
                itemBuilder: (context, index) {
                  return _buildSupportServiceCard(
                    supportServices[index]['service']!,
                    supportServices[index]['description']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Contact Support Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Optional: Navigate to a contact page or open chat feature
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'Contact Support',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportServiceCard(String service, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
