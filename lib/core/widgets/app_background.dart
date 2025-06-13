import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  final bool showPattern;
  
  const AppBackground({
    super.key,
    required this.child,
    this.showGradient = true,
    this.showPattern = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // خلفية متدرجة
        gradient: showGradient ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
            Theme.of(context).scaffoldBackgroundColor,
          ],
          stops: const [0.0, 0.5, 1.0],
        ) : null,
        color: showGradient ? null : Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          // نمط الخلفية
          if (showPattern) _buildBackgroundPattern(context),
          
          // المحتوى الرئيسي
          child,
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: BackgroundPatternPainter(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.03),
        ),
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  final Color color;
  
  BackgroundPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const double spacing = 50.0;
    const double dotSize = 2.0;

    // رسم نقاط متكررة
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          dotSize,
          paint,
        );
      }
    }

    // رسم خطوط قطرية خفيفة
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.02)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double i = -size.height; i < size.width; i += spacing * 2) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// خلفية بسيطة بدون نمط
class SimpleBackground extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  
  const SimpleBackground({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            (backgroundColor ?? Theme.of(context).scaffoldBackgroundColor),
            (backgroundColor ?? Theme.of(context).scaffoldBackgroundColor)
                .withValues(alpha: 0.8),
          ],
        ),
      ),
      child: child,
    );
  }
}

// خلفية مع صورة
class ImageBackground extends StatelessWidget {
  final Widget child;
  final String? imagePath;
  final double opacity;
  
  const ImageBackground({
    super.key,
    required this.child,
    this.imagePath,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: imagePath != null ? DecorationImage(
          image: AssetImage(imagePath!),
          fit: BoxFit.cover,
          opacity: opacity,
        ) : null,
      ),
      child: child,
    );
  }
}
