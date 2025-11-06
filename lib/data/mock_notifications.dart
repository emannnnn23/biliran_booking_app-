// lib/data/mock_notifications.dart
// -------------------------------------------------------
// MOCK DATA: Notifications (Fixed Version)
// -------------------------------------------------------
// This file contains a list of notification objects with
// consistent fields: title, message, time, and isRead.
// -------------------------------------------------------

class AppNotification {
  final String title;
  final String message;
  final String time; // example: "2h ago" or "Just now"
  bool isRead; // mutable for future updates

  AppNotification({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

// ✅ List of mock notifications
List<AppNotification> mockNotifications = [
  AppNotification(
    title: '🎉 Booking Successful!',
    message: 'Your booking with Maria’s Catering has been confirmed.',
    time: '2h ago',
    isRead: false,
  ),
  AppNotification(
    title: '📅 Event Reminder',
    message: 'Your event with Almeria Events Place is scheduled tomorrow.',
    time: '1d ago',
    isRead: true,
  ),
  AppNotification(
    title: '💬 New Message',
    message: 'Light & Sound Pro sent you a new message.',
    time: '3d ago',
    isRead: true,
  ),
];

// ✅ Function to dynamically add new notifications
void addNotification(String title, String message) {
  mockNotifications.insert(
    0,
    AppNotification(
      title: title,
      message: message,
      time: 'Just now',
      isRead: false,
    ),
  );
}
