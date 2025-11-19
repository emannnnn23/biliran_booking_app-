// lib/screens/product_details_page.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/product_model.dart';
import 'chat_page.dart';
import '../data/mock_messages.dart';
import '../data/mock_user.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 🔹 Assume current client is logged in
    final currentUser = mockUsers.firstWhere(
      (u) => u.role == "Client",
      orElse: () => mockUsers.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
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

            // NAME
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // PRICE
            Text(
              "₱${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 20),

            // SELLER
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/profile_placeholder.png"),
                ),
                const SizedBox(width: 10),
                Text(
                  "Sold by ${product.seller}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const Divider(height: 30),

            // DESCRIPTION
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(product.description),
            const SizedBox(height: 100),
          ],
        ),
      ),

      // BOTTOM BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // CHAT SELLER
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text("Chat Seller"),
                onPressed: () {
                  // 1️⃣ Try to find existing thread
                  MockMessageThread? thread = mockThreads.firstWhere(
                    (t) =>
                        t.clientEmail == currentUser.email &&
                        t.providerEmail ==
                            "${product.seller.toLowerCase()}@mock.com",
                    orElse: () => MockMessageThread(
                      clientEmail: currentUser.email,
                      providerEmail:
                          "${product.seller.toLowerCase()}@mock.com",
                      providerName: product.seller,
                      providerImage:
                          "assets/images/profile_placeholder.png",
                      messages: [
                        ChatMessage(
                          sender: currentUser.email,
                          text: "Hello! I'm interested in ${product.name}.",
                          time: DateTime.now(),
                        )
                      ], clientName: '',
                    ),
                  );

                  // 2️⃣ Add thread if new
                  if (!mockThreads.contains(thread)) {
                    mockThreads.add(thread);
                  }

                  // 3️⃣ Open Chat
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        thread: thread,
                        currentUserEmail: currentUser.email,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // BUY NOW
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text("Buy Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
