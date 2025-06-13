import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/Pages/home/home.dart';
import 'package:hue/Pages/auth/signup.dart';
import 'package:hue/core/services/error_handler.dart';
import 'package:hue/core/services/navigation_service.dart';
import 'package:hue/core/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // تسجيل الدخول
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (response.user != null) {
        _showSuccessMessage('تم تسجيل الدخول بنجاح');
        
        // الانتقال إلى الصفحة الرئيسية
        NavigationService.navigateAndRemoveUntil(const HomePage());
      } else {
        _showErrorMessage('فشل في تسجيل الدخول');
      }
    } catch (e) {
      final errorMessage = ErrorHandler.handleSupabaseError(e);
      _showErrorMessage(errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // عرض رسالة خطأ
  void _showErrorMessage(String message) {
    if (mounted) {
      NavigationService.showErrorSnackbar(message);
    }
  }

  // عرض رسالة نجاح
  void _showSuccessMessage(String message) {
    if (mounted) {
      NavigationService.showSuccessSnackbar(message);
    }
  }

  // التحقق من صحة البريد الإلكتروني
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    
    if (!GetUtils.isEmail(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    
    if (!value.endsWith(Constants.emailDomain)) {
      return Constants.invalidEmailDomain;
    }
    
    return null;
  }

  // التحقق من صحة كلمة المرور
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    
    if (value.length < 8) {
      return Constants.invalidPassword;
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // شعار التطبيق
                Icon(
                  Icons.school,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                
                const SizedBox(height: 24),
                
                Text(
                  'مرحباً بك',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'سجل دخولك للمتابعة',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // حقل البريد الإلكتروني
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    hintText: 'example@horus.edu.eg',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // حقل كلمة المرور
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  onFieldSubmitted: (_) => _login(),
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    hintText: 'أدخل كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword 
                            ? Icons.visibility_outlined 
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // زر تسجيل الدخول
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('تسجيل الدخول'),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // رابط نسيان كلمة المرور
                TextButton(
                  onPressed: () {
                    // TODO: تنفيذ نسيان كلمة المرور
                    _showErrorMessage('هذه الميزة غير متاحة حال<|im_start|>');
                  },
                  child: const Text('نسيت كلمة المرور؟'),
                ),
                
                const SizedBox(height: 24),
                
                // خط فاصل
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'أو',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // رابط إنشاء حساب جديد
                OutlinedButton(
                  onPressed: () {
                    NavigationService.navigateTo(const SignUpPage());
                  },
                  child: const Text('إنشاء حساب جديد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
