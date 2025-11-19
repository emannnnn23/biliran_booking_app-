// lib/screens/client_home_page.dart
// -------------------------------------------------------
// CLIENT HOME PAGE (Dynamic + Marketplace + Search)
// -------------------------------------------------------
// Features:
// ✅ Displays client's name and address dynamically
// ✅ Marketplace button on the top-left
// ✅ Search bar for filtering services
// ✅ Reads data from mockUsers (persistent frontend state)
// -------------------------------------------------------

import 'package:biliran_booking_app/screens/main_navigation.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_data.dart';
import '../data/mock_user.dart'; // ✅ to access saved user info
import '../models/service_model_package.dart';
import 'booking_confirmation_page.dart';
import 'marketplace_feed_page.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  Map? _arguments;
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_arguments == null) {
      _arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Extract user email from arguments
    final email = _arguments?['email'];

    // ✅ Retrieve user data directly from mockUsers
    final user = mockUsers.firstWhere(
      (u) => u.email == email,
      orElse: () => MockUser(
        email: '',
        password: '',
        role: 'Client',
      ),
    );

    // ✅ Dynamic user info
    final firstName = user.firstName ?? 'Client';
    final barangay = user.barangay ?? 'Unknown Barangay';
    final municipality = user.municipality ?? 'Biliran Province';
    final prefs = user.preferences ?? [];

    return Scaffold(
      // -------------------------------------------------------
      // 🔹 APP BAR
      // -------------------------------------------------------
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $firstName!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              '$barangay, $municipality',
              style: const TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search services or products',
            onPressed: () {
              // Show search bar dialog
              showSearch(
                context: context,
                delegate: ServiceSearchDelegate(),
              );
            },
          ),
        ],
      ),

      // -------------------------------------------------------
      // 🔹 SIDEBAR DRAWER
      // -------------------------------------------------------
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

      // -------------------------------------------------------
      // 🔹 BODY CONTENT (Services Feed + Marketplace Button)
      // -------------------------------------------------------
      body: HomeFeedScreen(
        preferences: prefs,
        barangay: barangay,
        municipality: municipality,
      ),
    );
  }
}

// -------------------------------------------------------
// 🧩 HOME FEED SCREEN (Dynamic Service Feed + Marketplace Link)
// -------------------------------------------------------
class HomeFeedScreen extends StatelessWidget {
  final String barangay;
  final String municipality;
  final List preferences;

  const HomeFeedScreen({
    super.key,
    required this.barangay,
    required this.municipality,
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
          
// 🛍️ Marketplace Icon Button (Top Left)
// -------------------------------------------------------
Align(
  alignment: Alignment.centerRight,
  child: IconButton(
    icon: const Icon(Icons.storefront_outlined, size: 30, color: AppColors.primary),
    tooltip: "Open Marketplace",
    onPressed: () {
      MainNavigation.of(context)?.goToMarketplace();
    },
  ),
),


          const SizedBox(height: 16),

          // -------------------------------------------------------
          // 📍 Location & Preferences Info
          // -------------------------------------------------------
          Text(
            'Showing services in $barangay, $municipality',
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

          // -------------------------------------------------------
          // 🧱 SERVICE FEED (Dynamic Packages)
          // -------------------------------------------------------
          const Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),

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
                      // 👩‍💼 Provider Info
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

                      // 📦 Package Info
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

                      // 🟩 Book Now Button
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
// 🔍 SEARCH DELEGATE (Basic Search Feature)
// -------------------------------------------------------
class ServiceSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = mockPackages
        .where((pkg) =>
            pkg.title.toLowerCase().contains(query.toLowerCase()) ||
            pkg.provider.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text('No matching results found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final pkg = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(pkg.provider.profileImage),
          ),
          title: Text(pkg.title),
          subtitle: Text(pkg.provider.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmationPage(package: pkg),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search for services...'));
  }
}
