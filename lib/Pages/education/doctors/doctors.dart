import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'DoctorProfilePage.dart';

class DoctorsPage extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Ahmed Mohamed",
      "specialty": "Computer Science Specialist",
      "imageUrl": '',
      "experience": "12 Years Experience",
      "rating": 4.0,
      "patients": "1,200+ Patients",
      "hospital": "Cairo University Hospital",
    },
    {
      "name": "Dr. Ali Hassan",
      "specialty": "Mathematics Professor",
      "imageUrl": '',
      "experience": "10 Years Experience",
      "rating": 4.5,
      "patients": "950+ Patients",
      "hospital": "Alexandria Medical Center",
    },
    {
      "name": "Dr. Dalia Kamal",
      "specialty": "Chemistry Researcher",
      "imageUrl": '',
      "experience": "8 Years Experience",
      "rating": 4.2,
      "patients": "700+ Patients",
      "hospital": "National Science Institute",
    },
    {
      "name": "Dr. Omar Farouk",
      "specialty": "Physics Consultant",
      "imageUrl": '',
      "experience": "15 Years Experience",
      "rating": 4.8,
      "patients": "2,000+ Patients",
      "hospital": "Tech University Hospital",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Our Specialists', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.blue[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
      ),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
          tooltip: 'Search doctors',
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSpecialtyFilter(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => DoctorCard(doctor: doctors[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtyFilter() {
    final specialties = [
      'All', 'Computer Science', 'Mathematics', 
      'Chemistry', 'Physics', 'Biology'
    ];
    
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) => FilterChip(
          label: Text(specialties[index]),
          selected: index == 0,
          onSelected: (bool selected) {},
          backgroundColor: Colors.grey[200],
          selectedColor: Colors.blue[100],
          labelStyle: TextStyle(
            color: index == 0 ? Colors.blue[800] : Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          showCheckmark: false,
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search doctors...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _navigateToDoctorProfile(context, doctor),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(context),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorNameAndSpecialty(),
                    const SizedBox(height: 8),
                    _buildRatingRow(),
                    const SizedBox(height: 12),
                    _buildDoctorDetails(),
                    const SizedBox(height: 12),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Hero(
      tag: 'doctor-image-${doctor['name']}',
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: doctor['imageUrl'].isEmpty
              ? Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.person,
                      size: 40, color: Colors.grey[500]),
                )
              : CachedNetworkImage(
                  imageUrl: doctor['imageUrl'],
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.error, color: Colors.grey),
                  ),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _buildDoctorNameAndSpecialty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctor['name'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          doctor['specialty'],
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: doctor['rating'],
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 18,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
          ignoreGestures: true,
        ),
        const SizedBox(width: 8),
        Text(
          '${doctor['rating']} (${doctor['patients']})',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorDetails() {
    return Column(
      children: [
        _buildDetailRow(Icons.work_outline, doctor['experience']),
        const SizedBox(height: 6),
        _buildDetailRow(Icons.local_hospital_outlined, doctor['hospital']),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue[600]),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Book Now'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue[800],
              side: BorderSide(color: Colors.blue[800]!),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _navigateToDoctorProfile(context, doctor),
            child: const Text('Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToDoctorProfile(BuildContext context, Map<String, dynamic> doctor) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DoctorProfilePage(doctor: doctor),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}