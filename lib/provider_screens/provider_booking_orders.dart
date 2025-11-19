// lib/screens/provider/provider_booking_orders_page.dart

import 'package:flutter/material.dart';
import '../../theme.dart';

class ProviderBookingOrdersPage extends StatelessWidget {
  final String email;
  const ProviderBookingOrdersPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _orderCard("Photo Coverage", "Dec 12, 2025", "Pending"),
          _orderCard("Catering", "Dec 20, 2025", "Approved"),
          _orderCard("Lights & Sound", "Jan 05, 2026", "Completed"),
        ],
      ),
    );
  }

  Widget _orderCard(String service, String date, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      child: ListTile(
        title: Text(service),
        subtitle: Text("Date: $date"),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == "Pending"
                ? Colors.orange
                : status == "Approved"
                    ? AppColors.primary
                    : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
