// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'reset_password.dart';
import '../home/home.dart';
import 'signup.dart';
import 'package:hue/core/utils/app_colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  // عرض رسالة منبثقة
  void _showSnackBar(String message, {Color color = LoginColors.errorColor}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // التحقق من صحة البريد الإلكتروني
  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // التحقق من صحة كلمة المرور
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  // وظيفة تسجيل الدخول
  Future<void> _login() async {
    if (_isLoading) return; // تجنب إرسال طلبات متعددة أثناء التحميل

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('الرجاء ملء جميع الحقول');
      return;
    }

    if (!_isEmailValid(email)) {
      _showSnackBar('الرجاء إدخال بريد إلكتروني صحيح');
      return;
    }

    if (!_isPasswordValid(password)) {
      _showSnackBar('كلمة المرور يجب أن تكون على الأقل 8 أحرف');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null && mounted) {
        // عند النجاح في تسجيل الدخول، الانتقال إلى الصفحة الرئيسية
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Home()),
          (route) => false, // إزالة جميع الصفحات السابقة
        );
      } else {
        _showSnackBar('فشل تسجيل الدخول، تأكد من بياناتك');
      }
    } on AuthException catch (e) {
      // التعامل مع أخطاء مصادقة Supabase
      _showSnackBar(e.message);
    } catch (e) {
      // التعامل مع الأخطاء العامة
      _showSnackBar('حدث خطأ غير متوقع');
      print('Login error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false); // إيقاف التحميل
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
        centerTitle: true,
        backgroundColor: LoginColors.primaryColor, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Home()),
            (route) => false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text(
                "مرحبًا بعودتك!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: LoginColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "سجل الدخول لاستخدام حسابك",
                style: TextStyle(
                  fontSize: 16,
                  color: LoginColors.greyColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword 
                          ? Icons.visibility_off 
                          : Icons.visibility
                    ),
                    onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LoginColors.primaryColor, 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: LoginColors.buttonTextColor,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 18,
                            color: LoginColors.buttonTextColor, 
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResetPassword() ),
                ),
                child: const Text(
                  'RESET PASSWORD?',
                  style: TextStyle(
                    color: LoginColors.warningColor, 
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpPage() ),
                ),
                child: const Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                  ),
                  style: TextStyle(
                    color: LoginColors.warningColor,
                    fontSize: 16,
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
