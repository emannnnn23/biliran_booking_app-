// lib/screens/provider/provider_booking_orders_page.dart

import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../data/mock_provider_booking_orders_data.dart';

class ProviderBookingOrdersPage extends StatelessWidget {
  final String email;
  const ProviderBookingOrdersPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Filter orders BELONGING ONLY to this provider
    final providerOrders = mockProviderBookingOrders
        .where((o) => o.providerEmail == email)
        .toList();

    return Scaffold(
      body: providerOrders.isEmpty
          ? const Center(
              child: Text(
                "No booking orders yet.",
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: providerOrders.length,
              itemBuilder: (context, index) {
                final order = providerOrders[index];
                return _orderCard(order);
              },
            ),
    );
  }

  Widget _orderCard(ProviderBookingOrder order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.serviceName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text)),

            const SizedBox(height: 4),
            Text("Client: ${order.clientName}",
                style: const TextStyle(fontSize: 14, color: AppColors.muted)),

            const SizedBox(height: 4),
            Text("Date: ${order.date}",
                style: const TextStyle(fontSize: 14, color: AppColors.muted)),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(order.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: _statusColor(order.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Approved":
        return AppColors.primary;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
