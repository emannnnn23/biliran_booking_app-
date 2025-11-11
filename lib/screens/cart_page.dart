// lib/screens/cart_page.dart
// -------------------------------------------------------
// 🛒 CART PAGE (Order History Mode)
// -------------------------------------------------------
// - Shows list of purchased items
// - Each item has a Cancel Order button
// - Checkout shows Thank You dialog but keeps orders visible
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../data/mock_cart_data.dart';
import '../theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalAmount => getCartTotal();

  // ✅ Checkout flow: shows Thank You, but keeps cart data
  void _checkout() {
    if (mockCart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your cart is empty."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Confirm Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "You are about to confirm ${mockCart.length} order(s).\n\n"
          "Total amount: ₱${totalAmount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              Navigator.pop(context); // Close confirmation dialog

              // ✅ Wait for safe frame (avoid layout errors)
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showThankYouDialog();
              });
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  // ✅ Thank You dialog — keeps orders in cart
  void _showThankYouDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Thank You! 🎉"),
        content: const Text(
          "Your order has been placed successfully.\n"
          "You can view your orders below.",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              Navigator.pop(context); // Close Thank You dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Checkout successful!"),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // ✅ Cancel individual order
  void _removeItem(int index) {
    setState(() => mockCart.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order cancelled."),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        automaticallyImplyLeading: true,
      ),
      body: mockCart.isEmpty
          ? const Center(
              child: Text(
                "You have no orders yet 🛍",
                style: TextStyle(fontSize: 16, color: AppColors.muted),
              ),
            )
          : Column(
              children: [
                // 🧾 LIST OF ORDERS
                Expanded(
                  child: ListView.builder(
                    itemCount: mockCart.length,
                    itemBuilder: (context, index) {
                      final item = mockCart[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.text,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "₱${item.product.discountedPrice.toStringAsFixed(2)} x ${item.quantity}",
                                        style: const TextStyle(
                                          color: AppColors.text,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Payment: ${item.paymentMethod}",
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.redAccent,
                                  ),
                                  tooltip: "Cancel Order",
                                  onPressed: () => _removeItem(index),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Subtotal: ₱${item.subtotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 🧮 TOTAL + CHECKOUT
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ₱${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _checkout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
