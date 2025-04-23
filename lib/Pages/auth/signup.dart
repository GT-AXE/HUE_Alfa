import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home.dart'; // تأكد من استيراد الصفحة الرئيسية
import 'package:hue/core/utils/app_colors.dart'; // تأكد من مسار الألوان

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // التحقق من صحة البريد الإلكتروني
  bool _isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  // التحقق من صحة كلمة المرور
  bool _isValidPassword(String password) {
    return password.length >= 8; // تأكد أن كلمة المرور تحتوي على 8 أحرف على الأقل
  }

  // التحقق من صحة العمر
  bool _isValidAge(String age) {
    final intAge = int.tryParse(age);
    return intAge != null && intAge >= 18;
  }

  // التحقق من صحة الاسم الكامل
  bool _isValidFullName(String fullName) {
    return fullName.isNotEmpty; // تأكد من أن الاسم الكامل ليس فارغًا
  }

  // دالة التسجيل
  Future<void> _signUp() async {
    String name = _nameController.text.trim();
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String age = _ageController.text.trim();

    // التحقق من صحة البيانات
    if (!_isValidFullName(fullName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("يرجى إدخال الاسم الكامل."),
          backgroundColor: SignUpColors.errorColor,
        ),
      );
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("يرجى إدخال بريد إلكتروني صالح."),
          backgroundColor: SignUpColors.errorColor,
        ),
      );
      return;
    }

    if (!_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("كلمة المرور يجب أن تكون على الأقل 8 أحرف."),
          backgroundColor: SignUpColors.errorColor,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("كلمة المرور وتأكيد كلمة المرور لا يتطابقان."),
          backgroundColor: SignUpColors.errorColor,
        ),
      );
      return;
    }

    if (!_isValidAge(age)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("يرجى إدخال عمر أكبر من 18."),
          backgroundColor: SignUpColors.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; // تفعيل مؤشر التحميل
    });

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      setState(() {
        _isLoading = false; // إيقاف مؤشر التحميل
      });

      if (response.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()), // الصفحة الرئيسية
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("فشل إنشاء الحساب. تأكد من صحة البيانات."),
              backgroundColor: SignUpColors.errorColor,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // إيقاف مؤشر التحميل في حال حدوث استثناء
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى."),
            backgroundColor: SignUpColors.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
        backgroundColor: SignUpColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Text(
                "Create a new account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: SignUpColors.appBarColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Fill in your details to sign up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: SignUpColors.greyColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person, color: SignUpColors.appBarColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person, color: SignUpColors.appBarColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@domain.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email, color: SignUpColors.appBarColor),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter a strong password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock, color: SignUpColors.appBarColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock, color: SignUpColors.appBarColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.calendar_today, color: SignUpColors.appBarColor),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp, // تعطيل الزر أثناء التحميل
                style: ElevatedButton.styleFrom(
                  backgroundColor: SignUpColors.signUpButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: SignUpColors.buttonTextColor) // مؤشر تحميل أثناء التسجيل
                    : const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: SignUpColors.buttonTextColor,
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
