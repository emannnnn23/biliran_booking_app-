// lib/screens/provider/provider_product_list_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderProductListPage extends StatelessWidget {
  final String email;
  const ProviderProductListPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((u) => u.email == email);
    final productList = user.sellingProducts ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: productList.isEmpty
            ? const Center(
                child: Text(
                  "No products added yet.",
                  style: TextStyle(color: AppColors.muted),
                ),
              )
            : ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(productList[i]),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Product (To build)")),
          );
        },
      ),
    );
  }
}
