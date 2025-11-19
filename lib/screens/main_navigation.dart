// lib/screens/main_navigation.dart
// -------------------------------------------------------
// MAIN NAVIGATION CONTROLLER (Persistent Bottom Navigation)
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import 'client_home_page.dart';
import 'booking_page.dart';
import 'messages_page.dart';
import 'profile_page.dart';
import 'marketplace_feed_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  // Allow other pages to call navigation actions
  static _MainNavigationState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainNavigationState>();

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Normal tab switching
  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  // ⭐ SPECIAL: Go to Marketplace INSIDE PageView
  void goToMarketplace() {
    _pageController.jumpToPage(4);
    setState(() => _currentIndex = 0); // Keep Home selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ClientHomePage(),     // index 0
          BookingsScreen(),     // index 1
          MessagesScreen(),     // index 2
          ProfilePage(),        // index 3
          MarketplaceFeedScreen(), // index 4 (hidden)
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.muted,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
