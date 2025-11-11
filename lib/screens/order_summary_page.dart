import 'package:flutter/material.dart';
import '../data/mock_cart_data.dart';
import '../models/product_model.dart';
import '../theme.dart';
import 'cart_page.dart';

class OrderSummaryPage extends StatelessWidget {
  final Product product;
  final int quantity;
  final String paymentMethod;

  const OrderSummaryPage({
    super.key,
    required this.product,
    required this.quantity,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = product.discountedPrice * quantity;

    void _confirmOrder() {
      addToCart(product, quantity: quantity, paymentMethod: paymentMethod);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order confirmed for "${product.name}"!'),
          backgroundColor: AppColors.primary,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(product.image,
                    height: 80, width: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.text)),
              ),
            ]),
            const SizedBox(height: 20),
            _summaryRow('Quantity', '$quantity pcs'),
            _summaryRow('Unit Price', '₱${product.discountedPrice.toStringAsFixed(2)}'),
            _summaryRow('Payment Method', paymentMethod),
            const Divider(height: 30),
            _summaryRow('Total', '₱${totalPrice.toStringAsFixed(2)}', bold: true),
            const Spacer(),
            ElevatedButton(
              onPressed: _confirmOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Confirm Order',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              color: bold ? AppColors.text : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
