import 'package:flutter/material.dart';

class WarningsPage extends StatelessWidget {
  const WarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceRecords = _getAttendanceData();
    final attendanceStats = _calculateAttendanceStats(attendanceRecords);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(attendanceStats),
          _buildBody(attendanceRecords),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(AttendanceStats stats) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Attendance Tracker',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 4, color: Colors.black26)])),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade700,
                Colors.blue.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_month, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildStatCircle(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  SliverList _buildBody(List<AttendanceRecord> records) {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Recent Attendance',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800)),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Last 30 days',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600)),
        ),
        const SizedBox(height: 16),
        ...records.map((record) => _buildAttendanceCard(record)).toList(),
        const SizedBox(height: 40),
        _buildReportButton(),
        const SizedBox(height: 20),
      ]),
    );
  }

  Widget _buildAttendanceCard(AttendanceRecord record) {
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
                    color: record.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    record.statusIcon,
                    color: record.statusColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(record.course,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        '${record.date} • ${record.time}',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: record.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: record.statusColor.withOpacity(0.3)),
                  ),
                  child: Text(record.status,
                      style: TextStyle(
                          color: record.statusColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.download, size: 20),
        label: const Text('Download Full Report'),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade50,
          foregroundColor: Colors.indigo.shade700,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  List<AttendanceRecord> _getAttendanceData() {
    return [
      AttendanceRecord(
        'Math 101',
        '2025-04-10',
        '09:00 AM',
        'Present',
        Colors.green.shade600,
        Icons.check_circle,
      ),
      AttendanceRecord(
        'Science 101',
        '2025-04-11',
        '10:30 AM',
        'Absent',
        Colors.red.shade600,
        Icons.cancel,
      ),
      AttendanceRecord(
        'Literature 101',
        '2025-04-12',
        '01:00 PM',
        'Present',
        Colors.green.shade600,
        Icons.check_circle,
      ),
      AttendanceRecord(
        'History 101',
        '2025-04-13',
        '11:15 AM',
        'Late',
        Colors.orange.shade600,
        Icons.watch_later,
      ),
      AttendanceRecord(
        'Computer Science',
        '2025-04-14',
        '02:45 PM',
        'Present',
        Colors.green.shade600,
        Icons.check_circle,
      ),
    ];
  }

  AttendanceStats _calculateAttendanceStats(List<AttendanceRecord> records) {
    final presentCount = records.where((r) => r.status == 'Present').length;
    final absentCount = records.where((r) => r.status == 'Absent').length;
    final lateCount = records.where((r) => r.status == 'Late').length;
    final total = records.length;
    final rate = total > 0 ? ((presentCount + lateCount * 0.5) / total * 100).round() : 0;

    return AttendanceStats(
      presentCount: presentCount,
      absentCount: absentCount,
      lateCount: lateCount,
      attendanceRate: rate,
    );
  }
}

class AttendanceRecord {
  final String course;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final IconData statusIcon;

  AttendanceRecord(
    this.course,
    this.date,
    this.time,
    this.status,
    this.statusColor,
    this.statusIcon,
  );
}

class AttendanceStats {
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int attendanceRate;

  AttendanceStats({
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.attendanceRate,
  });
}