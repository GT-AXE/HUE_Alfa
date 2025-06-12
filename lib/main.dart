import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/Pages/home/welcome.dart';
import 'package:hue/core/utils/app_theme.dart';
import 'package:hue/core/utils/constants.dart';
import 'package:hue/core/services/error_handler.dart';
import 'package:hue/core/controllers/app_controller.dart';

void main() async {
  // ضمان تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // تعيين توجيه الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // تهيئة معالج الأخطاء
  await ErrorHandler.initialize();
  
  try {
    // تهيئة Supabase
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnonKey,
    );
    
    // تسجيل وحدة التحكم الرئيسية
    Get.put(AppController());
    
    runApp(const HueApp());
  } catch (e) {
    ErrorHandler.reportError(e, null);
    runApp(const ErrorApp());
  }
}

class HueApp extends StatelessWidget {
  const HueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hue',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomePage(),
      builder: (context, child) {
        // معالجة الأخطاء في بناء الواجهة
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return ErrorHandler.buildErrorWidget(details.exception.toString());
        };
        
        if (child == null) {
          return const Scaffold(
            body: Center(
              child: Text('حدث خطأ غير متوقع'),
            ),
          );
        }
        
        return child;
      },
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[700]),
              const SizedBox(height: 16),
              const Text(
                'حدث خطأ أثناء تشغيل التطبيق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('إغلاق التطبيق'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
