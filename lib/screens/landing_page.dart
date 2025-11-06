// lib/screens/landing_page.dart
// -------------------------------------------------------
// LANDING PAGE
// -------------------------------------------------------
// This is the first screen users see when opening the app.
// It introduces the Biliran Province Booking App and allows
// users to choose between "Log In" or "Sign Up".
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart'; // import the app theme colors

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea ensures content doesn’t overlap with phone notches
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // App title / branding
              const Text(
                'Biliran Province\nBooking App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),

              const SizedBox(height: 10),

              // Short tagline / description
              const Text(
                'Discover, connect, and book creative professionals\nand services across Biliran Province.',
                style: TextStyle(fontSize: 16, color: AppColors.muted),
              ),

              const Spacer(),

              // 🟩 LOG IN button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Log In'),
              ),

              const SizedBox(height: 12),

              // 🟨 SIGN UP button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
