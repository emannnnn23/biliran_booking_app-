// lib/screens/client_location_page.dart
// -------------------------------------------------------
// CLIENT LOCATION PAGE (Connected to Mock User Data)
// -------------------------------------------------------
// After selecting preferences, the client chooses their preferred
// municipality in Biliran Province. Their location and preferences
// are saved to the mockUsers data before navigating to the home page.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../data/mock_user.dart';
import '../theme.dart';

class ClientLocationPage extends StatefulWidget {
  const ClientLocationPage({super.key});

  @override
  State<ClientLocationPage> createState() => _ClientLocationPageState();
}

class _ClientLocationPageState extends State<ClientLocationPage> {
  // 🔹 List of Biliran municipalities
  final List<String> _locations = [
    'Naval',
    'Biliran',
    'Caibiran',
    'Almeria',
    'Kawayan',
    'Culaba',
    'Maripipi',
    'Cabucgayan',
  ];

  String? _selectedLocation;
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Retrieve email passed from Client Preference Page
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'] ?? '';

    // If preferences were passed (optional, for future)
    final preferences = args?['preferences'] ?? [];
    if (preferences.isNotEmpty) {
      updateClientPreferences(email, List<String>.from(preferences));
    }
  }

  // 🔹 Handle Continue Button
  void _continue() {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your location.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // ✅ Save location in mock database
    updateClientLocation(email, _selectedLocation!);

    // ✅ Navigate to client home
    Navigator.pushReplacementNamed(
      context,
      '/main',
      arguments: {
        'email': email,
        'location': _selectedLocation,
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome! Your location has been set to $_selectedLocation.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your preferred location in Biliran Province:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Dropdown menu for location selection
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Preferred Location',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              value: _selectedLocation,
              items: _locations
                  .map((loc) => DropdownMenuItem(
                        value: loc,
                        child: Text(loc),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedLocation = value);
              },
            ),

            const Spacer(),

            // 🔹 Continue button
            ElevatedButton(
              onPressed: _continue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
