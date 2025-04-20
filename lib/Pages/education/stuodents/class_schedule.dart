import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _selectedFilter = 'All';

  final List<String> _weekDays = ['All', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  final List<Map<String, dynamic>> _schedule = [
    {
      'day': 'Monday',
      'time': '8:00 AM - 10:00 AM',
      'subject': 'Introduction to Cybersecurity',
      'teacher': 'Dr. Ahmed Mohamed',
      'location': 'Room 201',
      'color': const Color(0xFF6C5CE7),
      'icon': Icons.cell_tower_outlined,
      'status': 'upcoming',
    },
    {
      'day': 'Monday',
      'time': '10:30 AM - 12:30 PM',
      'subject': 'Cybercrime Analysis',
      'teacher': 'Dr. Sara Ali',
      'location': 'Lab B',
      'color': const Color(0xFF00B894),
      'icon': Icons.pest_control_sharp,
      'status': 'online',
    },
    {
      'day': 'Tuesday',
      'time': '8:00 AM - 10:00 AM',
      'subject': 'Vulnerability Analysis',
      'teacher': 'Prof. Khalid Hassan',
      'location': 'Room 105',
      'color': const Color(0xFFE17055),
      'icon': Icons.pest_control_sharp,
      'status': 'cancelled',
    },
    {
      'day': 'Wednesday',
      'time': '9:00 AM - 11:00 AM',
      'subject': 'Cryptography',
      'teacher': 'Dr. Fatima Abdullah',
      'location': 'Room 302',
      'color': const Color(0xFF0984E3),
      'icon': Icons.lock_rounded,
      'status': 'completed',
    },
    {
      'day': 'Friday',
      'time': '11:00 AM - 1:00 PM',
      'subject': 'Computer Science',
      'teacher': 'Dr. Omar Mahmoud',
      'location': 'Lab A',
      'color': const Color(0xFFFD79A8),
      'icon': Icons.computer_rounded,
      'status': 'upcoming',
    },
  ];

  List<Map<String, dynamic>> get _filteredSchedule {
    if (_selectedFilter == 'All') return _schedule;
    return _schedule.where((item) => item['day'] == _selectedFilter).toList();
  }

  final Map<String, Color> _statusColors = {
    'upcoming': Colors.blue,
    'cancelled': Colors.red,
    'online': Colors.green,
    'completed': Colors.grey,
  };

  final Map<String, String> _statusLabels = {
    'upcoming': 'Upcoming',
    'cancelled': 'Cancelled',
    'online': 'Online',
    'completed': 'Completed',
  };

  Color _getStatusColor(String status) => _statusColors[status] ?? Colors.blue;

  String _getStatusLabel(String status) => _statusLabels[status] ?? 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        title: Text(
          '📅 Class Schedule',
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4B7BE5),
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Schedule',
              style: GoogleFonts.tajawal(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2D3436),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your classes for this week',
              style: GoogleFonts.tajawal(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),

            // Filters
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _weekDays.length,
                itemBuilder: (context, index) {
                  final day = _weekDays[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      label: Text(day),
                      selected: _selectedFilter == day,
                      onSelected: (_) => setState(() => _selectedFilter = day),
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF4B7BE5),
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        color: _selectedFilter == day ? Colors.white : Colors.grey.shade700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Header Row
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Center(child: Text('Day', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(child: Center(child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(child: Center(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Schedule List
            Expanded(
              child: ListView.separated(
                itemCount: _filteredSchedule.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = _filteredSchedule[index];
                  return _buildScheduleRow(
                    context,
                    item['subject'],
                    item['day'],
                    item['time'],
                    item['status'],
                    item['color'],
                    item['icon'],
                    item['teacher'],
                    item['location'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Add new class', style: GoogleFonts.tajawal()),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
        backgroundColor: const Color(0xFF4B7BE5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildScheduleRow(
    BuildContext context,
    String subject,
    String day,
    String time,
    String status,
    Color color,
    IconData icon,
    String teacher,
    String location,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _showClassDetails(context, subject, day, time, status, color, icon, teacher, location),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(subject, style: GoogleFonts.tajawal(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Expanded(child: Text(day, textAlign: TextAlign.center)),
            Expanded(child: Text(time, textAlign: TextAlign.center)),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getStatusColor(status).withOpacity(0.3), width: 1),
                ),
                child: Text(
                  _getStatusLabel(status),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: _getStatusColor(status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClassDetails(
    BuildContext context,
    String subject,
    String day,
    String time,
    String status,
    Color color,
    IconData icon,
    String teacher,
    String location,
  ) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subject, style: GoogleFonts.tajawal(fontSize: 18, fontWeight: FontWeight.w700)),
                        Text(teacher, style: GoogleFonts.tajawal(fontSize: 14, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.calendar_today_rounded, '$day • $time'),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.location_on_rounded, location),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.info_outline_rounded, 'Status: ${_getStatusLabel(status)}',
                  color: _getStatusColor(status)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Close', style: GoogleFonts.tajawal(color: Colors.grey.shade600)),
                    ),
                  ),
                  if (status == 'upcoming' || status == 'online')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          status == 'online' ? 'Join Now' : 'Remind Me',
                          style: GoogleFonts.tajawal(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? Colors.grey.shade600),
        const SizedBox(width: 12),
        Text(text, style: GoogleFonts.tajawal(color: color ?? Colors.grey.shade800)),
      ],
    );
  }
}
