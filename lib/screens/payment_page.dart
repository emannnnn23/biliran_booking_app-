// lib/screens/payment_page.dart
import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../theme.dart';

class PaymentPage extends StatelessWidget {
  final Booking booking;

  const PaymentPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Payment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),

            // Booking summary
            Text('Provider: ${booking.provider.name}'),
            Text('Package: ${booking.package.title}'),
            Text('Amount: ₱${booking.package.price.toStringAsFixed(0)}'),
            const SizedBox(height: 30),

            // Simulate payment options
            const Text('Choose Payment Method:'),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Pay with GCash'),
              onTap: () {
                _simulatePayment(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Pay with Credit Card'),
              onTap: () {
                _simulatePayment(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 💳 Mock payment simulation
  void _simulatePayment(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful!')),
      );

      Navigator.pop(context); // Go back to booking details

      // ✅ In a real system, this would also update the booking status to "paid"
    });
  }
}
