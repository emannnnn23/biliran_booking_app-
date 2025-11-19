// lib/screens/provider/provider_booking_list_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderBookingListPage extends StatelessWidget {
  final String email;
  const ProviderBookingListPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = mockUsers.firstWhere((u) => u.email == email);
    final bookingList = user.bookingServices ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: bookingList.isEmpty
            ? const Center(
                child: Text(
                  "No booking services added yet.",
                  style: TextStyle(color: AppColors.muted),
                ),
              )
            : ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(bookingList[i]),
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
            const SnackBar(content: Text("Add Booking Service (To build)")),
          );
        },
      ),
    );
  }
}
