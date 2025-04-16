// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'application.dart';
import 'package:hue/core/utils/app_colors.dart';

class SubmissionsPage extends StatefulWidget {
  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  final List<Map<String, String>> _submissions = [];

  void _navigateToApplicationForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApplicationFormPage()),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        _submissions.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submissions', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: SubmissionsColors.appBarColor, // استخدام اللون المخصص لشريط العنوان
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _navigateToApplicationForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: SubmissionsColors.buttonColor, // استخدام اللون المخصص للزر
                foregroundColor: SubmissionsColors.buttonTextColor, // استخدام اللون الأبيض للنص
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Submit New Application', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _submissions.isEmpty
                  ? Center(
                      child: Text(
                        'No submissions yet',
                        style: TextStyle(fontSize: 16, color: SubmissionsColors.greyColor), // استخدام اللون الرمادي
                      ),
                    )
                  : ListView.builder(
                      itemCount: _submissions.length,
                      itemBuilder: (context, index) {
                        final submission = _submissions[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          color: SubmissionsColors.cardBackgroundColor, // استخدام اللون المخصص لخلفية البطاقة
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            title: Text(
                              'Student Name: ${submission['studentName']}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Status: Under Review (3 Days)',
                              style: TextStyle(fontSize: 14, color: SubmissionsColors.greyColor), // استخدام اللون الرمادي
                            ),
                            trailing: Icon(Icons.check_circle_outline, color: SubmissionsColors.appBarColor, size: 28), // استخدام اللون المخصص للأيقونة
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
