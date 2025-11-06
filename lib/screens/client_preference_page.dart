// lib/screens/client_preference_page.dart
// -------------------------------------------------------
// CLIENT PREFERENCE PAGE (Connected to Mock User Data)
// -------------------------------------------------------
// After OTP verification, clients land here to select
// event services they are interested in.
// Their selections are saved to mockUsers for personalization.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../data/mock_user.dart';
import '../theme.dart';

class ClientPreferencePage extends StatefulWidget {
  const ClientPreferencePage({super.key});

  @override
  State<ClientPreferencePage> createState() => _ClientPreferencePageState();
}

class _ClientPreferencePageState extends State<ClientPreferencePage> {
  // 🔹 Available service options
  final List<String> _options = [
    'Event Venues',
    'Catering Services',
    'Photographers',
    'Decorators',
    'Musicians / Bands',
    'Hosts & Coordinators',
    'Lighting & Sound System',
  ];

  // 🔹 Selected options
  final Set<String> _selected = {};

  late String email; // from arguments

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Retrieve email passed from OTP verification
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'] ?? '';
  }

  // 🔹 Handle continue button
  void _next() {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one preference.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // ✅ Save selected preferences to mock user data
    updateClientPreferences(email, _selected.toList());

    // ✅ Navigate to next step — location setup
    Navigator.pushNamed(
      context,
      '/client/location',
      arguments: {'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Preferences'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose the services you’re interested in:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Dynamic checkbox list of options
            Expanded(
              child: ListView(
                children: _options.map((option) {
                  final isSelected = _selected.contains(option);
                  return CheckboxListTile(
                    value: isSelected,
                    title: Text(option),
                    activeColor: AppColors.primary,
                    onChanged: (checked) {
                      setState(() {
                        checked == true
                            ? _selected.add(option)
                            : _selected.remove(option);
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Continue button
            ElevatedButton(
              onPressed: _next,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
