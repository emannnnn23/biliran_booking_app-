// lib/screens/provider/provider_booking_setup_page.dart

import 'package:biliran_booking_app/provider_screens/provider_main_navigation.dart';
import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';


class ProviderBookingSetupPage extends StatefulWidget {
  const ProviderBookingSetupPage({super.key});

  @override
  State<ProviderBookingSetupPage> createState() =>
      _ProviderBookingSetupPageState();
}

class _ProviderBookingSetupPageState extends State<ProviderBookingSetupPage> {
  final List<String> allBookingCategories = [
    "Photography",
    "Videography",
    "Catering",
    "Makeup Artist",
    "Lights & Sound",
    "Event Organizer",
    "Event Host",
    "Decoration Services",
    "Band / Musicians"
  ];

  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final email = args?['email'];

    return Scaffold(
      appBar: AppBar(title: const Text("Setup Booking Services")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select the booking services you provide:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: allBookingCategories.length,
                itemBuilder: (context, index) {
                  final category = allBookingCategories[index];
                  final selected = selectedCategories.contains(category);

                  return CheckboxListTile(
                    title: Text(category),
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final user = mockUsers.firstWhere((u) => u.email == email);
                user.bookingServices = selectedCategories;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProviderMainNavigation(email: email),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Continue", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
