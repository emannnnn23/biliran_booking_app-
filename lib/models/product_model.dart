// lib/models/product_model.dart

class Product {
  final String id;
  final String name;
  final String seller;
  final String image;
  final double price;
  final String description;
  final DateTime datePosted;
  final double? discountPercent; // e.g., 0.10 = 10% off
  final double? discountAmount; // fixed peso amount

  Product({
    required this.id,
    required this.name,
    required this.seller,
    required this.image,
    required this.price,
    required this.description,
    required this.datePosted,
    this.discountPercent,
    this.discountAmount,
  });

  // 🧮 Calculate final price after discount
  double get discountedPrice {
    double discounted = price;
    if (discountPercent != null) {
      discounted -= price * discountPercent!;
    }
    if (discountAmount != null) {
      discounted -= discountAmount!;
    }
    return discounted < 0 ? 0 : discounted;
  }
  // 🏷️ Whether this product has any discount
  bool get hasDiscount => discountPercent != null || discountAmount != null;

  // 🕒 Time ago formatter (optional for UI feed)
  String get timeAgo {
    final diff = DateTime.now().difference(datePosted);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${datePosted.month}/${datePosted.day}/${datePosted.year}';
  }
}
