// lib/screens/otp_verification_page.dart
// -------------------------------------------------------
// OTP VERIFICATION PAGE (Unified for Client + Provider)
// -------------------------------------------------------
// After successful OTP entry, user verification status is
// updated in the mock database and redirected accordingly.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../data/mock_user.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpCtrl = TextEditingController();
  late String email;
  late String role;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'] ?? '';
    role = args?['role'] ?? 'Client';
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    final otp = _otpCtrl.text.trim();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      // ✅ Mark user as verified
      verifyMockUser(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP Verified for $email!'),
          backgroundColor: Colors.green,
        ),
      );

      // ✅ Redirect based on user role
      if (role == 'Client') {
        Navigator.pushReplacementNamed(
          context,
          '/client/preferences',
          arguments: {'email': email},
        );
      } else if (role == 'Service Provider') {
        Navigator.pushReplacementNamed(
          context,
          '/provider/setup',
          arguments: {'email': email},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unknown role.'),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully (mock).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Account')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              role == 'Client'
                  ? 'Enter the 6-digit OTP sent to your email to activate your client account.'
                  : 'Enter the 6-digit OTP sent to your email to verify your provider account.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // OTP Input Field
            TextField(
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '------',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // Verify Button
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Verify'),
            ),

            const SizedBox(height: 12),

            // Resend OTP Button
            TextButton(
              onPressed: _resendOtp,
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
