// lib/data/mock_cart_data.dart
// -------------------------------------------------------
// 🛒 MOCK CART DATA (Updated)
// -------------------------------------------------------
// Handles adding, removing, and calculating cart totals.
// Supports quantity, payment method, order date, and ID.
// Ready for frontend integration and backend expansion.
// -------------------------------------------------------

import '../models/product_model.dart';
import 'dart:math';

// 🧩 CART ITEM MODEL
class CartItem {
  final String id; // Unique order ID for tracking
  final Product product;
  int quantity;
  String paymentMethod;
  final DateTime orderDate;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
    this.paymentMethod = "GCash",
    DateTime? orderDate,
  }) : orderDate = orderDate ?? DateTime.now();

  double get subtotal => product.discountedPrice * quantity;
}

// 🛒 In-memory "database"
List<CartItem> mockCart = [];

// -------------------------------------------------------
// 🔹 ADD TO CART (handles duplicates gracefully)
// -------------------------------------------------------
void addToCart(
  Product product, {
  int quantity = 1,
  String paymentMethod = "GCash",
}) {
  try {
    // ✅ Check if item already exists
    final existingItem = mockCart.firstWhere(
      (item) => item.product.name == product.name,
    );

    // ✅ Update quantity & payment method
    existingItem.quantity += quantity;
    existingItem.paymentMethod = paymentMethod;
  } catch (e) {
    // ✅ Add as a new order item
    final newOrderId = "ORD-${Random().nextInt(999999)}";
    mockCart.add(
      CartItem(
        id: newOrderId,
        product: product,
        quantity: quantity,
        paymentMethod: paymentMethod,
      ),
    );
  }
}

// -------------------------------------------------------
// 🔹 REMOVE ITEM FROM CART
// -------------------------------------------------------
void removeFromCart(Product product) {
  mockCart.removeWhere((item) => item.product.name == product.name);
}

// -------------------------------------------------------
// 🔹 CLEAR ENTIRE CART
// -------------------------------------------------------
void clearCart() {
  mockCart.clear();
}

// -------------------------------------------------------
// 🔹 COMPUTE TOTAL PRICE
// -------------------------------------------------------
double getCartTotal() {
  return mockCart.fold(0, (sum, item) => sum + item.subtotal);
}

// -------------------------------------------------------
// 🔹 GENERATE CART SUMMARY (for debugging / backend send)
// -------------------------------------------------------
List<Map<String, dynamic>> getCartSummary() {
  return mockCart.map((item) {
    return {
      "order_id": item.id,
      "product_name": item.product.name,
      "quantity": item.quantity,
      "payment_method": item.paymentMethod,
      "subtotal": item.subtotal,
      "order_date": item.orderDate.toIso8601String(),
    };
  }).toList();
}
