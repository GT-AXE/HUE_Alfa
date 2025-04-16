import 'package:flutter/material.dart';
import 'package:hue/core/utils/assets.dart';
import 'package:hue/Pages/auth/login.dart';
import 'package:hue/Pages/home/home.dart';
import 'package:hue/core/utils/app_colors.dart'; // استيراد الألوان
import 'dart:math' as math;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDarkMode = false;
  bool showTitle = false;
  bool showSubtitle = false;
  bool showButtons = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => showTitle = true);
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => showSubtitle = true);
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() => showButtons = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDarkMode() => setState(() => isDarkMode = !isDarkMode);

  void _navigateTo(BuildContext context, Widget page, {bool replace = false}) {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, c) {
        final fade = Tween(begin: 0.0, end: 1.0).animate(a);
        final slide = Tween(begin: const Offset(0, 0.1), end: Offset.zero).animate(a);
        final scale = Tween(begin: 0.9, end: 1.0).animate(a);
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(
            position: slide,
            child: ScaleTransition(scale: scale, child: c),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 1000),
    );
    replace ? Navigator.pushReplacement(context, route) : Navigator.push(context, route);
  }

  Widget _buildAnimatedButton({
    required String text,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        double scale = 1.0;
        return GestureDetector(
          onTapDown: (_) => setState(() => scale = 0.95),
          onTapUp: (_) => setState(() => scale = 1.0),
          onTapCancel: () => setState(() => scale = 1.0),
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 100),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSecondary ? Colors.white : color,
                foregroundColor: isSecondary ? color : Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                side: isSecondary ? BorderSide(color: color, width: 2) : null,
                elevation: 5,
                shadowColor: color.withOpacity(0.5),
              ),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(icon, key: ValueKey(icon)),
              ),
              label: Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1),
              ),
              onPressed: onPressed,
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticle(Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * math.pi;
        final x = size.width * 0.5 + (size.width * 0.4) * math.cos(angle);
        final y = size.height * 0.5 + (size.height * 0.4) * math.sin(angle);
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFF0C1D6B).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backgroundColor = isDarkMode ? WelcomeColors.backgroundDark : WelcomeColors.backgroundLight;
    final textColor = isDarkMode ? Colors.white : WelcomeColors.darkBlue;
    final logo = isDarkMode ? Assets.imagesLogo : Assets.imagesLogoBlue;

    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [WelcomeColors.darkBlue, WelcomeColors.backgroundDark]
                  : [WelcomeColors.backgroundLight, Colors.white],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: Tween(begin: .80, end: 0.5).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          logo,
                          width: size.width * 1.2,
                          height: size.width * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: showTitle ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Transform.translate(
                        offset: Offset(0, showTitle ? 0 : 20),
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [WelcomeColors.yellow, WelcomeColors.yellow.withOpacity(0.7)],
                          ).createShader(bounds),
                          child: Text(
                            'Welcome to hue!',
                            style: TextStyle(
                              fontSize: size.width * 0.08,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              color: textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: showSubtitle ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Transform.translate(
                        offset: Offset(0, showSubtitle ? 0 : 20),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Your educational friend',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: textColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    AnimatedOpacity(
                      opacity: showButtons ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          _buildAnimatedButton(
                            text: 'Explore Home',
                            color: WelcomeColors.darkBlue,
                            icon: Icons.rocket_launch_rounded,
                            onPressed: () => _navigateTo(context, Home(), replace: true),
                          ),
                          const SizedBox(height: 15),
                          _buildAnimatedButton(
                            text: 'Log In',
                            color: WelcomeColors.yellow,
                            icon: Icons.login_rounded,
                            isSecondary: true,
                            onPressed: () => _navigateTo(context, const Login()),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: IconButton(
                    key: ValueKey(isDarkMode),
                    icon: Icon(
                      isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      color: textColor,
                      size: 30,
                    ),
                    onPressed: _toggleDarkMode,
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
