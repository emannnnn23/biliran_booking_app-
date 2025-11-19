// lib/screens/provider/provider_selling_setup_page.dart

import 'package:biliran_booking_app/provider_screens/provider_main_navigation.dart';
import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';


class ProviderSellingSetupPage extends StatefulWidget {
  const ProviderSellingSetupPage({super.key});

  @override
  State<ProviderSellingSetupPage> createState() =>
      _ProviderSellingSetupPageState();
}

class _ProviderSellingSetupPageState extends State<ProviderSellingSetupPage> {
  final List<String> allProducts = [
    "Flowers",
    "Bouquets",
    "Balloons",
    "Party Needs",
    "Souvenirs",
    "Event Decorations",
    "Gift Items",
    "Custom Props",
    "Event Materials"
  ];

  final List<String> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final email = args?['email'];

    return Scaffold(
      appBar: AppBar(title: const Text("Setup Product Selling")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select the products you sell:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  final selected = selectedProducts.contains(product);

                  return CheckboxListTile(
                    title: Text(product),
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedProducts.add(product);
                        } else {
                          selectedProducts.remove(product);
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
              child: const Text("Continue", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
