import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'package:hue/core/utils/assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define theme for consistent styling
    final theme = ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: CardTheme(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 20),
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About the App'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 4,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Animated logo with fade-in effect
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 800),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: const AssetImage(Assets.imagesLogo),
                    backgroundColor: Colors.black,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // App Information Card
                _buildAnimatedCard(
                  icon: Icons.info,
                  title: 'App Information',
                  children: [
                    _buildRow('Version', 'ALFA 0.0.1'),
                    _buildRow('Date', '2024/10/10'),
                    _buildRow('Status', 'Under Development'),
                    _buildRow('Developer', 'AXE'),
                  ],
                ),
                // Features Card
                _buildAnimatedCard(
                  icon: Icons.list,
                  title: 'Features',
                  children: [
                    'Schedule Management',
                    'Electronic Assignment Submission',
                    'Communication with Faculty Members',
                    'Access to Educational Resources',
                  ].map((e) => _buildBullet(e)).toList(),
                ),
                // Contact Card
                _buildAnimatedCard(
                  icon: Icons.contact_page,
                  title: 'Contact',
                  children: [
                    _buildContact(
                      icon: Icons.email,
                      text: 'dev_axe@horus.edu.eg',
                      onTap: () => _launchUrl('mailto:dev_axe@horus.edu.eg'),
                    ),
                    _buildContact(
                      icon: Icons.phone,
                      text: '+201012345678',
                      onTap: () => _launchUrl('tel:+201012345678'),
                    ),
                    _buildContact(
                      icon: Icons.wechat_sharp,
                      text: 'Through the app',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build an animated card with scale transition
  Widget _buildAnimatedCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: AppColors.primary, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),
                  ...children,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build a row for key-value pairs
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  // Build a bullet point for features
  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 10, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  // Build a contact row with tap functionality
  Widget _buildContact({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.primary),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: onTap != null ? AppColors.primary : Colors.grey[800],
                decoration: onTap != null ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Launch URLs for email and phone
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle error (e.g., show a snackbar)
    }
  }
}