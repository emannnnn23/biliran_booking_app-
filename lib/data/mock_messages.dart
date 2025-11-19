// lib/data/mock_messages.dart
// -------------------------------------------------------
// NEW UNIFIED MOCK MESSAGING MODEL
// Works for both CLIENT and PROVIDER chat systems
// -------------------------------------------------------

class ChatMessage {
  final String sender;      // email of sender
  final String text;
  final DateTime time;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
  });
}

class MockMessageThread {
  final String clientEmail;
  final String clientName;
  final String providerEmail;

  final String providerName;
  final String providerImage;

  List<ChatMessage> messages;

  MockMessageThread({
    required this.clientEmail,
    required this.clientName,
    required this.providerEmail,
    required this.providerName,
    required this.providerImage,
    required this.messages,
  });

  // Computed fields for UI
  String get lastMessage => messages.isNotEmpty ? messages.last.text : "";
  DateTime get lastTime =>
      messages.isNotEmpty ? messages.last.time : DateTime.now();
}

// -------------------------------------------------------
// 🧪 MOCK THREAD LIST (can be edited anytime)
// -------------------------------------------------------
List<MockMessageThread> mockThreads = [
  MockMessageThread(
    clientEmail: "client@example.com",
    clientName: "John Doe",
    providerEmail: "maria@provider.com",
    providerName: "Maria’s Catering",
    providerImage: "assets/images/maria.jpg",
    messages: [
      ChatMessage(
        sender: "maria@provider.com",
        text: "We’ll prepare everything for your event. 🎉",
        time: DateTime.now().subtract(const Duration(minutes: 20)),
      ),
      ChatMessage(
        sender: "client@example.com",
        text: "Thank you! Looking forward!",
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
    ],
  ),

  MockMessageThread(
    clientEmail: "client@example.com",
    clientName: "John Doe", 
    providerEmail: "lights@sound.com",
    providerName: "Light & Sound Pro",
    providerImage: "assets/images/lightsound.jpg",
    messages: [
      ChatMessage(
        sender: "lights@sound.com",
        text: "Setup will start at 3 PM as planned.",
        time: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ],
  ),
];
