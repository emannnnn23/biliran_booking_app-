// lib/data/mock_messages.dart
// -------------------------------------------------------
// MOCK DATA: Message Threads (Frontend Simulation)
// -------------------------------------------------------
// Each thread represents a conversation between the client
// and a service provider.
// -------------------------------------------------------

class MessageThread {
  final String providerName;
  final String providerImage;
  final String lastMessage;
  final DateTime timestamp;

  MessageThread({
    required this.providerName,
    required this.providerImage,
    required this.lastMessage,
    required this.timestamp,
  });
}

// 🧩 Simulated message threads list
List<MessageThread> mockMessages = [
  MessageThread(
    providerName: "Maria’s Catering",
    providerImage: "assets/images/maria.jpg",
    lastMessage: "We’ll prepare everything for your event. 🎉",
    timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
  ),
  MessageThread(
    providerName: "Almeria Events Place",
    providerImage: "assets/images/almeria.jpg",
    lastMessage: "Looking forward to your booking confirmation!",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  MessageThread(
    providerName: "Light & Sound Pro",
    providerImage: "assets/images/lightsound.jpg",
    lastMessage: "Setup will start at 3 PM as planned.",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
