// lib/screens/provider/provider_product_orders_page.dart

import 'package:flutter/material.dart';
import '../../theme.dart';

class ProviderProductOrdersPage extends StatelessWidget {
  final String email;
  const ProviderProductOrdersPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _orderCard("Flower Bouquet", "₱450", "Pending"),
          _orderCard("Balloon Set", "₱800", "Delivered"),
          _orderCard("Gift Box", "₱350", "Cancelled"),
        ],
      ),
    );
  }

  Widget _orderCard(String product, String price, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      child: ListTile(
        title: Text(product),
        subtitle: Text("Price: $price"),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == "Pending"
                ? Colors.orange
                : status == "Delivered"
                    ? Colors.green
                    : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
