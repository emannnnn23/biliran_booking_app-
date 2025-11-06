// lib/screens/notifications_page.dart
// -------------------------------------------------------
// NOTIFICATIONS PAGE (Fixed Version)
// -------------------------------------------------------
// Displays app notifications using AppNotification model.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_notifications.dart'; // ✅ fixed model import

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: mockNotifications.isEmpty
          ? const Center(
              child: Text(
                'No new notifications yet.',
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mockNotifications.length,
              itemBuilder: (context, index) {
                final notif = mockNotifications[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: notif.isRead
                        ? Colors.white
                        : AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: const Icon(
                        Icons.notifications_active_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      notif.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    subtitle: Text(
                      notif.message,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    trailing: Text(
                      notif.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        notif.isRead = true; // mark as read
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
