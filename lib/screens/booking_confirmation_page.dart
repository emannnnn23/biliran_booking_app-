// lib/screens/booking_confirmation_page.dart
// -------------------------------------------------------
// BOOKING CONFIRMATION PAGE (Frontend Simulation)
// -------------------------------------------------------
// ✅ Handles local booking confirmation logic only.
// ✅ Adds a booking to mockBookings.
// ✅ Shows a success popup.
// ✅ Returns to Client Home Page.
// ✅ Booking then appears in the Bookings tab automatically.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../models/service_model_package.dart';
import '../models/booking_model.dart';
import '../data/mock_bookings_data.dart';
import '../theme.dart';

class BookingConfirmationPage extends StatefulWidget {
  final ServicePackage package; // Data of the selected package

  const BookingConfirmationPage({super.key, required this.package});

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  DateTime? _selectedDate; // Stores the chosen event date

  // 🔹 FUNCTION: Confirm the booking process
  void _confirmBooking() {
    // 1️⃣ Check if the user has selected a date
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your event date first.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return; // stop execution if no date
    }

    // 2️⃣ Create a new mock Booking object
    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // unique ID
      clientName: 'John Doe', // mock client (will be dynamic later)
      bookingDate: DateTime.now(), // today's date
      eventDate: _selectedDate!, // selected event date
      provider: widget.package.provider, // provider from the package
      package: widget.package, // selected package
      status: BookingStatus.pending, // default status
    );

    // 3️⃣ Add the booking to the global mock list (simulating database)
    mockBookings.add(newBooking);

    

    // 4️⃣ Show a success popup dialog
    showDialog(
      context: context,
      barrierDismissible: false, // prevent accidental close
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          '🎉 Booking Successful!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your booking has been successfully placed.\n'
          'You can view it under the Bookings tab.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
              // 👆 This returns to the root page (Client Home)
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final package = widget.package; // shorthand access

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧾 PACKAGE SUMMARY CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package title
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Provider name
                  Text(
                    'By ${package.provider.name}',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 10),
                  // Price
                  Text(
                    '₱${package.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 📅 DATE PICKER SECTION
            const Text(
              'Select Event Date:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),

            // 🔘 Choose Date Button
            ElevatedButton.icon(
              onPressed: () async {
                // open Flutter date picker
                final today = DateTime.now();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: today,
                  lastDate: today.add(const Duration(days: 365)),
                );

                // If date is picked, update state
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text(
                _selectedDate == null
                    ? 'Choose Date'
                    : _selectedDate!.toLocal().toString().split(' ')[0],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(48),
              ),
            ),

            const Spacer(), // pushes confirm button to bottom

            // ✅ CONFIRM BOOKING BUTTON
            ElevatedButton.icon(
              onPressed: _confirmBooking, // calls booking logic
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirm Booking'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
