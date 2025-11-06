// lib/screens/chat_page.dart
// -------------------------------------------------------
// CHAT PAGE (Frontend Simulation)
// -------------------------------------------------------
// Opens when the client taps on a provider message thread
// or starts a new chat (like “Chat Seller” from a product).
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_messages.dart'; // ✅ access MessageThread model

class ChatPage extends StatefulWidget {
  final MessageThread thread; // passed from MessagesScreen or dynamic source

  const ChatPage({super.key, required this.thread});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // message list

  @override
  void initState() {
    super.initState();

    // 👇 If this chat doesn't exist in the mockMessages list yet, add it.
    final exists = mockMessages.any(
      (t) => t.providerName == widget.thread.providerName,
    );
    if (!exists) {
      mockMessages.insert(0, widget.thread); // add new chat to list
    }

    // 👇 Preload with mock conversation
    _messages.addAll([
      {'text': 'Hi! Just confirming your booking details.', 'isProvider': true},
      {'text': 'Yes, I’d like the setup by 3 PM.', 'isProvider': false},
      {'text': 'Got it. Our team will arrive by 2:30 PM.', 'isProvider': true},
    ]);
  }

  // 🔹 Send message simulation
  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isProvider': false}); // client message
    });
    _msgController.clear();

    // ✅ Update the last message in mockMessages
    final index = mockMessages.indexWhere(
        (t) => t.providerName == widget.thread.providerName);
    if (index != -1) {
      mockMessages[index] = MessageThread(
        providerName: widget.thread.providerName,
        providerImage: widget.thread.providerImage,
        lastMessage: text,
        timestamp: DateTime.now(),
      );
    }

    // Simulate provider auto-reply
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': 'Got it! We’ll keep you updated 😊',
          'isProvider': true,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.thread;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(provider.providerImage),
              radius: 16,
            ),
            const SizedBox(width: 10),
            Text(
              provider.providerName,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),

      // 🔹 Chat body
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg['text'], msg['isProvider']);
              },
            ),
          ),

          // 🔹 Message input
          SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
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

  // 🧱 Message bubble builder
  Widget _buildMessageBubble(String text, bool isProvider) {
    return Align(
      alignment:
          isProvider ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isProvider
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isProvider ? 0 : 16),
            bottomRight: Radius.circular(isProvider ? 16 : 0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isProvider ? AppColors.text : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
