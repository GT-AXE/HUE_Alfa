import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  // قائمة الأطباء مع تفاصيلهم
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Ahmed",
      "specialty": "Computer Science",
      "imageUrl": '',
      "experience": "12 Years Experience",
      "rating": 4.0,
    },
    {
      "name": "Dr. Ali",
      "specialty": "Mathematics",
      "imageUrl": '',
      "experience": "10 Years Experience",
      "rating": 4.5,
    },
    {
      "name": "Dr. dalia",
      "specialty": "Chemistry",
      "imageUrl": '',
      "experience": "8 Years Experience",
      "rating": 4.2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  // بناء شريط التطبيق العلوي
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Medical Staff', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A75BC), Color(0xFF33B0E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.8],
          ),
        ),
      ),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  // بناء محتوى الصفحة
  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F5F5), Color(0xFFE8F4F8)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: ListView.separated(
          itemCount: doctors.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) => DoctorCard(doctor: doctors[index]),
        ),
      ),
    );
  }
}

// الكارت الخاص بكل طبيب
class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  
  static const _nameStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2A3C4E),
  );
  
  static const _specialtyStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF607D8B),
    fontWeight: FontWeight.w500,
  );

  const DoctorCard({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showSelectionSnackbar(context, doctor['name']),
        splashColor: const Color(0xFF33B0E0).withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(screenWidth),
              const SizedBox(width: 16),
              Expanded(child: _buildDoctorInfo()),
            ],
          ),
        ),
      ),
    );
  }

  // بناء صورة البروفايل للطبيب
  Widget _buildProfileImage(double screenWidth) {
    return Container(
      width: screenWidth * 0.22,
      height: screenWidth * 0.22,
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: doctor['imageUrl'].isEmpty
          ? const Icon(Icons.person_rounded, size: 40, color: Color(0xFF90CAF9))
          : Image.asset(doctor['imageUrl'], fit: BoxFit.cover),
    );
  }

  // بناء معلومات الطبيب (الاسم، التخصص، التقييم...)
  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(doctor['name'], style: _nameStyle),
        const SizedBox(height: 6),
        Text(doctor['specialty'], style: _specialtyStyle),
        const SizedBox(height: 12),
        _buildRatingRow(),
        const SizedBox(height: 12),
        _buildExperienceRow(),
        const SizedBox(height: 12),
        _buildProfileButton(),
      ],
    );
  }

  // بناء صف التقييم (النجوم)
  Widget _buildRatingRow() {
    return Row(
      children: [
        _buildStarRating(doctor['rating']),
        const SizedBox(width: 8),
        Text(
          doctor['rating'].toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF607D8B)),
        ),
      ],
    );
  }

  // بناء النجوم بناءً على التقييم
  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (index) {
        final starColor = const Color(0xFFFFC107);
        final starSize = 20.0;
        
        if (index < rating.floor()) {
          return Icon(Icons.star_rounded, color: starColor, size: starSize);
        } else if (index == rating.floor() && rating % 1 >= 0.5) {
          return Icon(Icons.star_half_rounded, color: starColor, size: starSize);
        }
        return Icon(Icons.star_outline_rounded, color: starColor, size: starSize);
      }),
    );
  }

  // بناء صف الخبرة المهنية للطبيب
  Widget _buildExperienceRow() {
    return Row(
      children: [
        const Icon(Icons.work_history_rounded, 
            color: Color(0xFF33B0E0), size: 20),
        const SizedBox(width: 6),
        Text(
          doctor['experience'],
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF607D8B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // بناء زر عرض الملف الشخصي للطبيب
  Widget _buildProfileButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.person_outline, size: 18),
        label: const Text('View Profile'),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A75BC),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // إظهار Snackbar عند النقر على الطبيب
  void _showSelectionSnackbar(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $name'),
        backgroundColor: const Color(0xFF2A75BC),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
