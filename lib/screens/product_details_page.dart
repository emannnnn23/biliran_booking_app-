// lib/screens/product_details_page.dart
// -------------------------------------------------------
// PRODUCT DETAILS PAGE (with visible Chat Seller button)
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/product_model.dart';
import 'chat_page.dart';
import '../data/mock_messages.dart'; // ✅ import your MessageThread model

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Add to Wishlist',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to wishlist (mock).'),
                ),
              );
            },
          ),
        ],
      ),

      // -------------------------------------------------------
      // MAIN BODY
      // -------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ PRODUCT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 🧾 PRODUCT NAME
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 8),

            // 💰 PRICE
            Text(
              '₱${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 12),

            // 🧍‍♀️ SELLER INFO
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/profile_placeholder.png'),
                  radius: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'Sold by ${product.seller}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),

            const Divider(height: 30),

            // 📝 DESCRIPTION
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.description,
              style: const TextStyle(fontSize: 15, color: AppColors.text),
            ),
            const SizedBox(height: 100), // gives space before buttons
          ],
        ),
      ),

      // -------------------------------------------------------
      // FIXED BOTTOM ACTION BUTTONS
      // -------------------------------------------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 💬 Chat Seller
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // ✅ Use your MessageThread model here
                  final newThread = MessageThread(
                    providerName: product.seller,
                    providerImage: 'assets/images/profile_placeholder.png',
                    lastMessage:
                        'Hello! I’m interested in ${product.name}.',
                    timestamp: DateTime.now(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(thread: newThread),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Chat Seller'),
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color: AppColors.primary, width: 1.5),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 🛒 Buy Now
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Purchased "${product.name}" successfully (mock)!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
