import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hue/core/utils/app_colors.dart'; // ← غيّر الاسم حسب مشروعك

class DoctorProfilePage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfilePage({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                doctor['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      color: CourseDetailsColors.textShadow.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
              background: _buildProfileHeader(isDark),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareDoctorProfile(context),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorInfoSection(theme, isDark),
                  const SizedBox(height: 24),
                  _buildSpecialtySection(theme, isDark),
                  const SizedBox(height: 24),
                  _buildExperienceSection(theme, isDark),
                  const SizedBox(height: 24),
                  _buildRatingSection(theme, isDark),
                  const SizedBox(height: 24),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Stack(
      children: [
        if (doctor['imageUrl'].isNotEmpty)
          CachedNetworkImage(
            imageUrl: doctor['imageUrl'],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: isDark
                  ? CourseDetailsColors.fallbackBackgroundDark
                  : CourseDetailsColors.fallbackBackgroundLight,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: isDark
                  ? CourseDetailsColors.fallbackBackgroundDark
                  : CourseDetailsColors.fallbackBackgroundLight,
              child: const Icon(Icons.person, size: 60),
            ),
          )
        else
          Container(
            color: isDark
                ? CourseDetailsColors.fallbackBackgroundDark
                : CourseDetailsColors.fallbackBackgroundLight,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                CourseDetailsColors.gradientStart.withOpacity(0.7),
                CourseDetailsColors.gradientEnd,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInfoSection(ThemeData theme, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          child: ClipOval(
            child: doctor['imageUrl'].isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: doctor['imageUrl'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: isDark
                          ? CourseDetailsColors.fallbackBackgroundDark
                          : CourseDetailsColors.fallbackBackgroundLight,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: isDark
                          ? CourseDetailsColors.fallbackBackgroundDark
                          : CourseDetailsColors.fallbackBackgroundLight,
                      child: const Icon(Icons.person, size: 40),
                    ),
                  )
                : Container(
                    color: isDark
                        ? CourseDetailsColors.fallbackBackgroundDark
                        : CourseDetailsColors.fallbackBackgroundLight,
                    child: const Icon(Icons.person, size: 40),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor['name'],
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor['specialty'],
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.textTheme.titleMedium?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    doctor['hospital'] ?? "College of Artificial Intelligence",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtySection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialization',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isDark ? CourseDetailsColors.darkBackground : CourseDetailsColors.lightBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            doctor['specialtyDetails'] ??
                'Specializes in ${doctor['specialty']} With years of experience',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience and qualifications",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isDark ? CourseDetailsColors.darkBackground : CourseDetailsColors.lightBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExperienceItem(theme, Icons.work_outline,
                  doctor['experience'] ?? "years of experience"),
              const SizedBox(height: 12),
              _buildExperienceItem(theme, Icons.school_outlined,
                  doctor['qualification'] ?? "Dr in Cybersecurity"),
              const SizedBox(height: 12),
              _buildExperienceItem(theme, Icons.security_sharp,
                  doctor['services'] ?? 'Specialized in network security'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(ThemeData theme, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ratings",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isDark ? CourseDetailsColors.darkBackground : CourseDetailsColors.lightBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: doctor['rating']?.toDouble() ?? 4.5,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 28,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${doctor['rating']?.toStringAsFixed(1) ?? '4.5'} from 5',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${doctor['reviewsCount'] ?? '125'} evaluation',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: () {},
                        child: const Text("View all foods"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  label: const Text('Add your rating'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => _bookAppointment(context),
            child: const Text('Book an appointment'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () => _contactDoctor(context),
            child: const Text("Contact Dr"),
          ),
        ),
      ],
    );
  }

  void _bookAppointment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Book an appointment. ${doctor['name']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Select date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Pick the time',
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Successfully completed'),
                      ),
                    );
                  },
                  child: const Text('Confirm booking'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _contactDoctor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Communicate with Dr"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Make a call'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Send message'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancellation'),
            ),
          ],
        );
      },
    );
  }

  void _shareDoctorProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sharing doctor s illness..."),
      ),
    );
  }
}
