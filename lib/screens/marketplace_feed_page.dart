// lib/screens/marketplace_feed_screen.dart
import 'package:biliran_booking_app/screens/purchase_form_page.dart';
import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../theme.dart';
import '../models/product_model.dart';
import 'product_details_page.dart';
import 'cart_page.dart';

class MarketplaceFeedScreen extends StatelessWidget {
  const MarketplaceFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------------------------------------------------
      // 🔹 APP BAR
      // -------------------------------------------------------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          tooltip: 'View Cart',
          onPressed: () {
            Navigator.of(context).push(
              
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
        title: const Text('Marketplace'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search products',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon...')),
              );
            },
          ),
        ],
      ),

      // -------------------------------------------------------
      // 🔹 MAIN BODY
      // -------------------------------------------------------
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          final Product product = mockProducts[index];

          return GestureDetector(
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
                    // 🖼️ PRODUCT IMAGE + DISCOUNT BADGE
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            product.image,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (product.hasDiscount)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                product.discountPercent != null
                                    ? '${(product.discountPercent! * 100).toStringAsFixed(0)}% OFF'
                                    : '₱${product.discountAmount!.toStringAsFixed(0)} OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 🧾 PRODUCT NAME
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
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // 💰 PRICE WITH DISCOUNT
                    if (product.hasDiscount) ...[
                      Row(
                        children: [
                          Text(
                            '₱${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '₱${product.discountedPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ] else
                      Text(
                        '₱${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    const SizedBox(height: 10),

                    // 📝 DESCRIPTION
                    Text(
                      product.description.length > 100
                          ? '${product.description.substring(0, 100)}...'
                          : product.description,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 🛒 BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.info_outline),
                            label: const Text('View Details'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.primary, width: 1.5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsPage(product: product),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.shopping_cart_checkout),
                            label: const Text('Buy Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () async {
                              // ✅ Smooth transition feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Preparing purchase for "${product.name}"...'),
                                  backgroundColor: AppColors.primary,
                                  duration: const Duration(milliseconds: 700),
                                ),
                              );

                              // ✅ Wait briefly for layout stability
                              await Future.delayed(
                                  const Duration(milliseconds: 350));

                              if (!context.mounted) return;

                              // ✅ Navigate safely to PurchaseFormPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PurchaseFormPage(product: product),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
