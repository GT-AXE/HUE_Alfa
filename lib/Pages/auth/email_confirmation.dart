import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'login.dart';

class EmailConfirmationPage extends StatelessWidget {
  final String email;

  const EmailConfirmationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد البريد الإلكتروني'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_read,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            Text(
              'تم إرسال رابط التأكيد إلى',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              email,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'يرجى التحقق من بريدك الإلكتروني والنقر على الرابط لتأكيد حسابك.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('العودة إلى تسجيل الدخول'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}