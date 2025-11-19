// lib/screens/cart_page.dart
// -------------------------------------------------------
// 🛒 CART PAGE (Order List Only - No Checkout)
// -------------------------------------------------------

import 'package:biliran_booking_app/screens/marketplace_feed_page.dart';
import 'package:flutter/material.dart';
import '../data/mock_cart_data.dart';
import '../theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  // ❌ REMOVE ORDER
  void _removeItem(int index) {
    setState(() => mockCart.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order canceled.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
    
            

          }
        ),
        title: const Text("My Orders"),
        automaticallyImplyLeading: true,
      ),

      body: mockCart.isEmpty
          ? const Center(
              child: Text(
                "You have no orders yet 🛒",
                style: TextStyle(fontSize: 16, color: AppColors.muted),
              ),
            )
          : ListView.builder(
              itemCount: mockCart.length,
              itemBuilder: (context, index) {
                final item = mockCart[index];

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.product.image,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Payment: ${item.paymentMethod}",
                                  style: const TextStyle(
                                      color: AppColors.muted, fontSize: 13),
                                ),
                              ],
                            ),
                          ),

                          // ❌ Cancel button
                          IconButton(
                            icon: const Icon(Icons.cancel_outlined,
                                color: Colors.redAccent),
                            onPressed: () => _removeItem(index),
                          ),
                        ],
                      ),

                      const Divider(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₱${item.product.discountedPrice.toStringAsFixed(2)} x ${item.quantity}",
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.text),
                          ),
                          Text(
                            "Subtotal: ₱${item.subtotal.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
