// lib/provider_screens/provider_messages_page.dart
// -------------------------------------------------------
// PROVIDER MESSAGES PAGE — Shows conversations with clients
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_messages.dart';
import 'provider_chat_page.dart';

// Compatibility helper: expose a `clientName` accessor for various mock thread shapes.
// This uses dynamic access to tolerate different field names in the mock model
// (e.g. name, client, senderName). It returns 'Unknown' if no suitable field is found.
String _clientNameOf(Object? thread) {
  try {
    final dyn = thread as dynamic;
    return (dyn.clientName as String?) ??
           (dyn.name as String?) ??
           (dyn.client as String?) ??
           (dyn.senderName as String?) ??
           'Unknown';
  } catch (_) {
    return 'Unknown';
  }
}

class ProviderMessagesPage extends StatefulWidget {
  const ProviderMessagesPage({super.key});

  @override
  State<ProviderMessagesPage> createState() => _ProviderMessagesPageState();
}

class _ProviderMessagesPageState extends State<ProviderMessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Client Messages")),

      body: mockThreads.isEmpty
          ? const Center(
              child: Text(
                "No client messages yet.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: mockThreads.length,
              itemBuilder: (context, index) {
                final thread = mockThreads[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      backgroundImage:
                          const AssetImage("assets/images/profile_placeholder.png"),
                      radius: 25,
                    ),

                    // 🔥 Provider sees CLIENT NAME here
                    title: Text(
                      _clientNameOf(thread),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),

                    subtitle: Text(
                      thread.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.muted),
                    ),

                    trailing: Text(
                      _formatTime(thread.lastTime),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProviderChatPage(thread: thread),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";

    return "${time.month}/${time.day}/${time.year}";
  }
}
