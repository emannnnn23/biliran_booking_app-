import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme.dart';
import 'order_summary_page.dart';

class PurchaseFormPage extends StatefulWidget {
  final Product product;
  const PurchaseFormPage({super.key, required this.product});

  @override
  State<PurchaseFormPage> createState() => _PurchaseFormPageState();
}

class _PurchaseFormPageState extends State<PurchaseFormPage> {
  int quantity = 1;
  String paymentMethod = 'GCash';

  void _proceedToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSummaryPage(
          product: widget.product,
          quantity: quantity,
          paymentMethod: paymentMethod,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.image,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.text)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Select Quantity',
                style: TextStyle(fontWeight: FontWeight.w600)),
            Row(
              children: [
                IconButton(
                  onPressed:
                      quantity > 1 ? () => setState(() => quantity--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Select Payment Method',
                style: TextStyle(fontWeight: FontWeight.w600)),
            RadioListTile<String>(
              title: const Text('GCash'),
              value: 'GCash',
              groupValue: paymentMethod,
              onChanged: (value) => setState(() => paymentMethod = value!),
            ),
            RadioListTile<String>(
              title: const Text('Cash on Delivery'),
              value: 'COD',
              groupValue: paymentMethod,
              onChanged: (value) => setState(() => paymentMethod = value!),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _proceedToSummary,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Proceed to Checkout',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
