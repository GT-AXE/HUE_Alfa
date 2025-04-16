import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:hue/features/home/welcome.dart'; // Ensure the path is correct

void main() {
  runApp(const HueApp());
}

class HueApp extends StatelessWidget {
  const HueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
      title: 'Hue',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}