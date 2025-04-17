import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart'; 
import 'package:hue/Pages/home/welcome.dart'; 
import '../core/utils/app_colors.dart';
import '../core/utils/constants.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );

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
        brightness: Brightness.light,
        scaffoldBackgroundColor: mainColors.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: mainColors.appBarBackgroundColor, 
          foregroundColor: mainColors.appBarForegroundColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: mainColors.bodyTextColor),
          bodyMedium: TextStyle(color: mainColors.bodyTextColorMedium),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
