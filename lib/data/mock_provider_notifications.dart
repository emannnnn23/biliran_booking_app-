// lib/data/mock_provider_notifications.dart

class ProviderNotification {
  final String title;
  final String message;
  final String time;
  bool read;

  ProviderNotification({
    required this.title,
    required this.message,
    required this.time,
    this.read = false,
  });
}

List<ProviderNotification> providerNotifications = [
  ProviderNotification(
    title: "New Booking Request",
    message: "Client requested booking for Wedding Photography.",
    time: "2h ago",
  ),
  ProviderNotification(
    title: "New Product Order",
    message: "1x Floral Bouquet ordered by a client.",
    time: "4h ago",
  ),
  ProviderNotification(
    title: "New Message",
    message: "You received a message from Ana Santos.",
    time: "5h ago",
  ),
  ProviderNotification(
    title: "Verification Update",
    message: "Your business ID is under review.",
    time: "1 day ago",
  ),
];
