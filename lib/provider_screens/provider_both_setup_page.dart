// lib/screens/provider/provider_both_setup_page.dart

import 'package:biliran_booking_app/provider_screens/provider_main_navigation.dart';
import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';


class ProviderBothSetupPage extends StatefulWidget {
  const ProviderBothSetupPage({super.key});

  @override
  State<ProviderBothSetupPage> createState() =>
      _ProviderBothSetupPageState();
}

class _ProviderBothSetupPageState extends State<ProviderBothSetupPage> {
  final List<String> bookingOptions = [
    "Photography", "Videography", "Catering",
    "Makeup Artist", "Lights & Sound", "Decoration Services",
    "Event Organizer", "Band / Musicians"
  ];

  final List<String> productOptions = [
    "Flowers", "Balloons", "Bouquets",
    "Party Needs", "Souvenirs", "Gift Items",
    "Decor Materials", "Event Props"
  ];

  final List<String> selectedBooking = [];
  final List<String> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final email = args?['email'];

    return Scaffold(
      appBar: AppBar(title: const Text("Setup Your Services & Products")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Booking Services You Provide",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            ...bookingOptions.map((item) {
              return CheckboxListTile(
                title: Text(item),
                value: selectedBooking.contains(item),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedBooking.add(item);
                    } else {
                      selectedBooking.remove(item);
                    }
                  });
                },
              );
            }),

            const Divider(height: 40),

            const Text(
              "Products You Sell",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            ...productOptions.map((item) {
              return CheckboxListTile(
                title: Text(item),
                value: selectedProducts.contains(item),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedProducts.add(item);
                    } else {
                      selectedProducts.remove(item);
                    }
                  });
                },
              );
            }),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                final user = mockUsers.firstWhere((u) => u.email == email);
                user.bookingServices = selectedBooking;
                user.sellingProducts = selectedProducts;

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
              child: const Text("Finish Setup",
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
