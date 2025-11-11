// lib/screens/profile_page.dart
// -------------------------------------------------------
// 👤 DYNAMIC PROFILE PAGE (Editable User Information)
// -------------------------------------------------------
// - Loads real client data from mockUsers
// - Allows editing + saving (updates in-memory database)
// - Routes back to ClientHomePage after saving
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/mock_user.dart'; // ✅ Import mockUsers data

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false; // Toggles edit mode
  late String email;

  // 🧾 Controllers for editable text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _barangayController = TextEditingController();
  final _municipalityController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Get email from route arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'] ?? '';

    // ✅ Load user data from mockUsers
    final user = mockUsers.firstWhere(
      (u) => u.email == email,
      orElse: () => MockUser(email: '', password: '', role: 'Client'),
    );

    _nameController.text =
        "${user.firstName ?? ''} ${user.middleInitial ?? ''} ${user.lastName ?? ''}".trim();
    _emailController.text = user.email;
    _phoneController.text = user.phoneNumber ?? '';
    _barangayController.text = user.barangay ?? '';
    _municipalityController.text = user.municipality ?? '';
  }

  // -------------------------------------------------------
  // 💾 Save Updates
  // -------------------------------------------------------
  void _saveChanges() {
    // Split full name back into components (simple parse)
    final nameParts = _nameController.text.trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // ✅ Update the mock user info
    updateClientInfo(email, {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': _phoneController.text.trim(),
      'barangay': _barangayController.text.trim(),
      'municipality': _municipalityController.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // ✅ Route back to Home Page (auto-refreshes)
    Navigator.pushReplacementNamed(
      context,
      '/main',
      arguments: {'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------------------------------------------------
      // 🧭 APP BAR
      // -------------------------------------------------------
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: true,
        actions: [
          // ✏️ Edit/Save Button
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            tooltip: _isEditing ? 'Save Changes' : 'Edit Profile',
            onPressed: () {
              if (_isEditing) _saveChanges();
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),

      // -------------------------------------------------------
      // 🧱 BODY
      // -------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------------------------------------
            // 👤 PROFILE HEADER (Avatar + Name + Email)
            // -------------------------------------------------------
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        const AssetImage('assets/images/user_avatar.png'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'Your Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _emailController.text,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // -------------------------------------------------------
            // 🧾 ACCOUNT INFO FIELDS
            // -------------------------------------------------------
            const Text(
              "Account Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Editable Fields
            _editableField(
              label: "Full Name",
              controller: _nameController,
              icon: Icons.person_outline,
              isEditable: _isEditing,
            ),
            _editableField(
              label: "Email Address",
              controller: _emailController,
              icon: Icons.email_outlined,
              isEditable: false, // email is fixed
            ),
            _editableField(
              label: "Phone Number",
              controller: _phoneController,
              icon: Icons.phone_outlined,
              isEditable: _isEditing,
            ),
            _editableField(
              label: "Barangay",
              controller: _barangayController,
              icon: Icons.home_outlined,
              isEditable: _isEditing,
            ),
            _editableField(
              label: "Municipality",
              controller: _municipalityController,
              icon: Icons.location_city_outlined,
              isEditable: _isEditing,
            ),

            const SizedBox(height: 30),

            // -------------------------------------------------------
            // 🚪 LOGOUT BUTTON
            // -------------------------------------------------------
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------
  // 🧩 REUSABLE FIELD BUILDER
  // -------------------------------------------------------
  Widget _editableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isEditable,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: isEditable,
        style: const TextStyle(fontSize: 15, color: AppColors.text),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.primary),
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.muted),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
