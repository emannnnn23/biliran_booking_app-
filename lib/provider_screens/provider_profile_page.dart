// lib/screens/provider/provider_profile_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderProfilePage extends StatelessWidget {
  final String email;
  const ProviderProfilePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((u) => u.email == email);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 15),

            Text(
              user.businessName ?? "Business Name",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 5),
            Text(user.email, style: const TextStyle(color: AppColors.muted)),

            const Divider(height: 40),

            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text("${user.barangay}, ${user.municipality}"),
            ),

            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(user.phoneNumber ?? "No phone number"),
            ),

            ListTile(
              leading: const Icon(Icons.business_center),
              title: Text("Service Type: ${user.serviceType}"),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
