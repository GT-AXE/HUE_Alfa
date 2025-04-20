import 'package:flutter/material.dart';

class AppFonts {
  static const String mainFont = 'Cairo'; // تأكد من إضافته في pubspec.yaml

  static const TextStyle titleStyle = TextStyle(
    fontFamily: mainFont,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: mainFont,
    fontSize: 16,
    color: Colors.black87,
  );
}
