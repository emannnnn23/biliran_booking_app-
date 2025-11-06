// lib/models/service_provider_model.dart
// -------------------------------------------------------
// MODEL: SERVICE PROVIDER
// -------------------------------------------------------
// Represents a creative professional or business offering
// event-related services in the Biliran Province Booking App.
// -------------------------------------------------------

class ServiceProvider {
  final String id; // Unique identifier
  final String name; // Provider name (e.g., "Maria's Catering")
  final String category; // e.g., "Catering Services"
  final String profileImage; // URL or asset path for profile image
  final String location; // Municipality (e.g., Naval, Biliran)
  final double rating; // Average rating (for future use)
  final int totalReviews; // Number of client reviews

  ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.profileImage,
    required this.location,
    this.rating = 0.0,
    this.totalReviews = 0,
  });
}
