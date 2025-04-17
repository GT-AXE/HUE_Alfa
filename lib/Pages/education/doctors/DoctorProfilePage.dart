import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DoctorProfilePage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfilePage({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctor['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileImage(MediaQuery.of(context).size.width),
            const SizedBox(height: 16),
            Text(
              doctor['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              doctor['specialty'],
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              doctor['experience'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildRatingRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double screenWidth) {
    return Container(
      width: screenWidth * 0.4,
      height: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: doctor['imageUrl'].isEmpty
          ? const Icon(Icons.person_rounded, size: 80, color: Color(0xFF90CAF9))
          : CachedNetworkImage(
              imageUrl: doctor['imageUrl'],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
    );
  }

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
            color: Color(0xFF607D8B),
          ),
        ),
      ],
    );
  }

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
}
