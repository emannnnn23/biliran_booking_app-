// lib/data/mock_bookings.dart
// -------------------------------------------------------
// MOCK BOOKINGS DATA
// -------------------------------------------------------
// Stores all simulated client bookings dynamically.
// When a client books, the BookingConfirmationPage adds
// to this list so it appears in the Bookings tab.
// -------------------------------------------------------

import '../models/booking_model.dart';
import '../data/mock_data.dart'; // reuse mock packages & providers

final List<Booking> mockBookings = [
  Booking(
    id: 'bkg1',
    package: mockPackages[0],
    provider: mockPackages[0].provider,
    bookingDate: DateTime.now().subtract(const Duration(days: 2)),
    eventDate: DateTime.now().add(const Duration(days: 7)),
    status: BookingStatus.confirmed,
    clientName: 'John Doe',
  ),
  Booking(
    id: 'bkg2',
    package: mockPackages[1],
    provider: mockPackages[1].provider,
    bookingDate: DateTime.now().subtract(const Duration(days: 5)),
    eventDate: DateTime.now().add(const Duration(days: 15)),
    status: BookingStatus.pending,
    clientName: 'John Doe',
  ),
];
