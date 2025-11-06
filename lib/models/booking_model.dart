// lib/models/booking_model.dart
// -------------------------------------------------------
// MODEL: BOOKING
// -------------------------------------------------------
// Represents a booking made by a client for a service package.
// This model connects the client, provider, and package together.
// -------------------------------------------------------

import 'service_model_package.dart';
import 'service_provider_model.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

class Booking {
  final String id; // Unique booking ID
  final ServicePackage package; // The package being booked
  final ServiceProvider provider; // Provider offering the package
  final DateTime bookingDate; // Date when the booking was made
  final DateTime eventDate; // Scheduled event date
  final BookingStatus status; // Current booking status
  final String clientName; // Name of the client

  Booking({
    required this.id,
    required this.package,
    required this.provider,
    required this.bookingDate,
    required this.eventDate,
    required this.status,
    required this.clientName,
  });
}
