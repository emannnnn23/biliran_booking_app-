// lib/screens/provider/provider_dashboard_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderDashboardPage extends StatelessWidget {
  final String email;
  const ProviderDashboardPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((u) => u.email == email);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${user.businessName ?? user.firstName ?? 'Provider'}!",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 20),

            // ----------- DASHBOARD CARDS -----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dashboardCard(Icons.receipt_long, "Orders", "12"),
                _dashboardCard(Icons.star, "Rating", "4.8"),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dashboardCard(Icons.inventory, "Items/Services", "8"),
                _dashboardCard(Icons.people, "Clients", "32"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(IconData icon, String title, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 35, color: AppColors.primary),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
