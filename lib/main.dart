// lib/main.dart
// -------------------------------------------------------
// ENTRY POINT of Biliran Province Booking App (Frontend UI)
// -------------------------------------------------------


import 'package:biliran_booking_app/screens/client_information_page.dart';
import 'package:flutter/material.dart';
import 'theme.dart'; // We'll create this next
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/otp_verification_page.dart';
import 'screens/client_preference_page.dart';
import 'screens/client_home_page.dart';
import 'screens/main_navigation.dart';

// Main function — starting point of every Flutter app
void main() {
  runApp(const BiliranProvinceBookingApp());
}

// Root widget of the app
class BiliranProvinceBookingApp extends StatelessWidget {
  const BiliranProvinceBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biliran Province Booking App',
    
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(), // apply theme from theme.dart
      
      

      // Define your app’s initial screen
      initialRoute: '/',

      // Define named routes for navigation between pages
      routes: {
        '/':(context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/otp': (context) => const OtpVerificationPage(),
        '/client/preferences': (context) => const ClientPreferencePage(),
        '/client/info': (context) => const ClientInformationPage(),
        '/client/home': (context) => const ClientHomePage(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}
