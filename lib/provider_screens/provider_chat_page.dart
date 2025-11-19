// lib/provider_screens/provider_chat_page.dart
// -------------------------------------------------------
// PROVIDER CHAT PAGE — Provider replies to clients
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_messages.dart';

class ProviderChatPage extends StatefulWidget {
  final MockMessageThread thread;

  const ProviderChatPage({super.key, required this.thread});

  @override
  State<ProviderChatPage> createState() => _ProviderChatPageState();
}

class _ProviderChatPageState extends State<ProviderChatPage> {
  final TextEditingController _controller = TextEditingController();
  late MockMessageThread thread;

  @override
  void initState() {
    super.initState();
    thread = widget.thread;
  }

  // 📩 Provider sends message
  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newMsg = ChatMessage(
      sender: thread.providerEmail,
      text: text,
      time: DateTime.now(),
    );

    setState(() {
      thread.messages.add(newMsg);
    });

    _controller.clear();
    _updateThread();
  }

  void _updateThread() {
    final index = mockThreads.indexWhere((t) =>
        t.clientEmail == thread.clientEmail &&
        t.providerEmail == thread.providerEmail);

    if (index != -1) mockThreads[index] = thread;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/profile_placeholder.png"),
              radius: 16,
            ),
            const SizedBox(width: 10),
            Text(thread.clientName),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: thread.messages.length,
              itemBuilder: (context, index) {
                final msg = thread.messages[index];
                final isProvider = msg.sender == thread.providerEmail;

                return _bubble(msg.text, isProvider);
              },
            ),
          ),

          SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(String text, bool isProvider) {
    return Align(
      alignment: isProvider ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isProvider
              ? AppColors.primary
              : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isProvider ? 16 : 0),
            bottomRight: Radius.circular(isProvider ? 0 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isProvider ? Colors.white : AppColors.text,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
