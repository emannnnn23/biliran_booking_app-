// lib/screens/client_preference_page.dart
// -------------------------------------------------------
// CLIENT PREFERENCE PAGE (Connected to Mock User Data)
// -------------------------------------------------------
// After the client fills out the information form,
// they land here to select event services they are interested in.
// The selected preferences are saved to mockUsers for personalization,
// and the user is redirected to their Home Page.
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
  Map<String, dynamic>? userInfo; // info passed from client info form

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Retrieve email and info passed from ClientInformationPage
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'] ?? '';
    userInfo = args?['info'] ?? {};
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

    // ✅ Navigate to Home Page and pass full info
    Navigator.pushReplacementNamed(
      context,
      '/main',
      arguments: {
        'email': email,
        'userInfo': userInfo,
        'preferences': _selected.toList(),
      
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferences saved successfully!'),
        backgroundColor: Colors.green,
      ),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Continue to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
