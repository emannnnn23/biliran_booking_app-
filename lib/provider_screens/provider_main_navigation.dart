// lib/screens/provider/provider_main_navigation.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

import 'provider_dashboard_page.dart';
import 'provider_booking_list.dart';
import 'provider_product_list.dart';
import 'provider_booking_orders.dart';
import 'provider_product_orders.dart';
import 'provider_profile_page.dart';

class ProviderMainNavigation extends StatefulWidget {
  final String email;
  const ProviderMainNavigation({super.key, required this.email});

  @override
  State<ProviderMainNavigation> createState() => _ProviderMainNavigationState();
}

class _ProviderMainNavigationState extends State<ProviderMainNavigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((u) => u.email == widget.email);

    // ----------------------------------------------------
    // BUILD TABS DYNAMICALLY
    // ----------------------------------------------------
    final List<Widget> pages = [];
    final List<BottomNavigationBarItem> navItems = [];

    // Always include Dashboard
    pages.add(ProviderDashboardPage(email: widget.email));
    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: "Dashboard",
    ));

    // -------------------------
    // BOOKING TABS
    // -------------------------
    if (user.serviceType == "booking" || user.serviceType == "both") {
      pages.add(ProviderBookingListPage(email: widget.email));
      navItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        activeIcon: Icon(Icons.calendar_month),
        label: "Booking",
      ));
    }

    // -------------------------
    // SELLING TABS
    // -------------------------
    if (user.serviceType == "selling" || user.serviceType == "both") {
      pages.add(ProviderProductListPage(email: widget.email));
      navItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.inventory_2_outlined),
        activeIcon: Icon(Icons.inventory_2),
        label: "Products",
      ));
    }

    // -------------------------
    // ORDERS TAB
    // -------------------------
    pages.add(
      (user.serviceType == "booking")
          ? ProviderBookingOrdersPage(email: widget.email)
          : ProviderProductOrdersPage(email: widget.email),
    );

    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: "Orders",
    ));

    // -------------------------
    // PROFILE TAB
    // -------------------------
    pages.add(ProviderProfilePage(email: widget.email));
    navItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: "Profile",
    ));

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _index = i),
        items: navItems,
      ),
    );
  }
}
