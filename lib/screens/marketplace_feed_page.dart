import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../theme.dart';
import '../models/product_model.dart';
import 'product_details_page.dart'; // 🆕 Import Product Details Page

// -------------------------------------------------------
// 🛍️ MARKETPLACE FEED SCREEN
// -------------------------------------------------------
// Displays creative products (paintings, crafts, artifacts).
// When the user taps a product, it opens the Product Details Page.
// -------------------------------------------------------
class MarketplaceFeedScreen extends StatelessWidget {
  const MarketplaceFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockProducts.length,
      itemBuilder: (context, index) {
        final Product product = mockProducts[index];

        return GestureDetector(
          // 🖱️ When tapped, open Product Details Page
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(product: product),
              ),
            );
          },

          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼️ PRODUCT IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 🧾 PRODUCT INFO
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'by ${product.seller}',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₱${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(color: AppColors.text),
                  ),
                  const SizedBox(height: 10),

                  // 🛒 BUY NOW BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart_checkout),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added "${product.name}" to your cart!',
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      label: const Text('Buy Now'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
