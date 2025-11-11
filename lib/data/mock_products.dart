import '../models/product_model.dart';

final List<Product> mockProducts = [
  Product(
    id: 'p1',
    name: 'Hand-painted Coconut Shell Bowl',
    image: 'assets/images/coconut.jpg',
    seller: 'Lara’s Art Studio',
    price: 450.0,
    description: 'Eco-friendly handmade bowl crafted from coconut shells.',
    discountAmount: 200.0,
    datePosted: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Product(
    id: 'p2',
    name: 'Biliran Landscape Painting',
    image: 'assets/images/landscape.jpg',
    seller: 'Art by Rico',
    price: 1200.0,
    discountAmount: 200.0,
    description: 'Original acrylic painting of Biliran’s coastal beauty.',
    datePosted: DateTime.now().subtract(const Duration(days: 2)),
  ),
];
