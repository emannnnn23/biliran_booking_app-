// lib/screens/provider/provider_notifications_page.dart

import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../data/mock_provider_notifications.dart';

class ProviderNotificationsPage extends StatefulWidget {
  const ProviderNotificationsPage({super.key});

  @override
  State<ProviderNotificationsPage> createState() => _ProviderNotificationsPageState();
}

class _ProviderNotificationsPageState extends State<ProviderNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: providerNotifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications yet.",
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: providerNotifications.length,
              itemBuilder: (context, index) {
                final notif = providerNotifications[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      notif.read = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: notif.read ? Colors.grey.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          notif.read
                              ? Icons.notifications_none
                              : Icons.notifications_active,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif.message,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.muted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notif.time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
