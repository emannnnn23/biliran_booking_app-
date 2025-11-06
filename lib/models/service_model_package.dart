// lib/models/service_package_model.dart
// -------------------------------------------------------
// MODEL: SERVICE PACKAGE
// -------------------------------------------------------
// Represents a package or offer posted by a Service Provider
// visible on the client’s feed or during booking.
// -------------------------------------------------------

import 'service_provider_model.dart';

class ServicePackage {
  final String id; // Unique identifier
  final String title; // Package name (e.g., "Full Wedding Package")
  final String description; // Short description
  final double price; // Price in PHP
  final List<String> images; // URLs or asset paths of package images
  final ServiceProvider provider; // The provider who owns this package
  final DateTime datePosted; // For feed sorting

  ServicePackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.provider,
    required this.datePosted,
  });
}
