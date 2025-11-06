// lib/screens/client_home_page.dart
// -------------------------------------------------------
// CLIENT HOME PAGE
// -------------------------------------------------------
// Features:
// - Sidebar Drawer (Menu)
// - Top AppBar with Search icon
// - Tab Navigation: Services + Marketplace
// - Dynamic content feed for both tabs
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_data.dart';
import '../data/mock_products.dart'; // 🆕 mock products data
import '../models/service_model_package.dart';
import '../models/product_model.dart';
import 'booking_confirmation_page.dart';

// -------------------------------------------------------
// 🏠 CLIENT HOME PAGE (Main Scaffold with Tabs + Drawer)
// -------------------------------------------------------
class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  Map? _arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_arguments == null) {
      _arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = _arguments?['location'] ?? 'Biliran Province';
    final List prefs = _arguments?['preferences'] ?? [];

    return DefaultTabController(
      length: 2, // 🔹 Two main tabs: Services & Marketplace
      child: Scaffold(
        // 🔹 APP BAR
        appBar: AppBar(
          title: const Text('Biliran Province Booking'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search services or products',
              onPressed: () {
                // 🔍 TODO: Add search functionality for services & products
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search feature coming soon...'),
                  ),
                );
              },
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home_repair_service), text: 'Services'),
              Tab(icon: Icon(Icons.shopping_bag_outlined), text: 'Marketplace'),
            ],
          ),
        ),

        // 🔹 SIDEBAR DRAWER MENU
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('My Bookings'),
                onTap: () => Navigator.pushNamed(context, '/bookings'),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),

        // 🔹 BODY CONTENT (TABS)
        body: TabBarView(
          children: [
            HomeFeedScreen(location: location, preferences: prefs),
            const MarketplaceFeedScreen(),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------
// 🧩 HOME FEED TAB (Dynamic Service Feed)
// -------------------------------------------------------
class HomeFeedScreen extends StatelessWidget {
  final String location;
  final List preferences;

  const HomeFeedScreen({
    super.key,
    required this.location,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context) {
    final prefsDisplay =
        preferences.isEmpty ? 'All Services' : preferences.join(', ');

    final List<ServicePackage> packages = List.from(mockPackages)
      ..sort((a, b) => b.datePosted.compareTo(a.datePosted));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Text(
            'Showing services in $location',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Based on your preferences: $prefsDisplay',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          const Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),

          // Dynamic Service Feed
          Column(
            children: packages.map((pkg) {
              return Container(
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
                      // Provider Info
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(pkg.provider.profileImage),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pkg.provider.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.text)),
                              Text(pkg.provider.category,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColors.muted)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Package Info
                      Text(pkg.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text)),
                      const SizedBox(height: 6),
                      Text(
                        '₱${pkg.price.toStringAsFixed(0)} • ${pkg.description}',
                        style: const TextStyle(color: AppColors.text),
                      ),
                      const SizedBox(height: 10),

                      // Book Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookingConfirmationPage(package: pkg),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------
// 🛍️ MARKETPLACE TAB (Creative Product Feed)
// -------------------------------------------------------
class MarketplaceFeedScreen extends StatelessWidget {
  const MarketplaceFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = List.from(mockProducts)
      ..sort((a, b) => b.datePosted.compareTo(a.datePosted));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
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
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(product.image,
                      height: 180, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                // Product Info
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text)),
                Text('by ${product.seller}',
                    style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 6),
                Text('₱${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 10),
                Text(product.description,
                    style: const TextStyle(color: AppColors.text)),
                const SizedBox(height: 10),
                // Buy Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_checkout_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Added "${product.name}" to your cart!'),
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
        );
      },
    );
  }
}
