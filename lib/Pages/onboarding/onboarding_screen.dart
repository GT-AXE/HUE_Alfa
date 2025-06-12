import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/Pages/home/welcome.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: "مرحباً بك في Hue",
      description: "منصتك التعليمية المتكاملة للتواصل والتعلم",
      image: "assets/images/onboarding1.png",
    ),
    OnboardingItem(
      title: "تواصل مع الأساتذة",
      description: "تواصل مباشر مع أساتذتك وزملائك في الدراسة",
      image: "assets/images/onboarding2.png",
    ),
    OnboardingItem(
      title: "تابع دراستك",
      description: "تابع واجباتك ومحاضراتك وجدولك الدراسي بسهولة",
      image: "assets/images/onboarding3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_items[index]);
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.image,
            height: 300,
          ),
          const SizedBox(height: 40),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: mainColors.titleTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            item.description,
            style: const TextStyle(
              fontSize: 16,
              color: mainColors.subtitleTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button
          TextButton(
            onPressed: _completeOnboarding,
            child: const Text(
              "تخطي",
              style: TextStyle(
                color: mainColors.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
          
          // Dots indicator
          Row(
            children: List.generate(
              _items.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? mainColors.primaryColor
                      : mainColors.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          
          // Next/Done button
          ElevatedButton(
            onPressed: () {
              if (_currentPage == _items.length - 1) {
                _completeOnboarding();
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              _currentPage == _items.length - 1 ? "ابدأ" : "التالي",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    // Save that onboarding is completed
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    // Navigate to welcome page
    Get.offAll(() => const WelcomePage());
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}