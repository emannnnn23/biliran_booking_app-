// lib/screens/profile_page.dart
// -------------------------------------------------------
// 👤 DYNAMIC PROFILE PAGE (Editable User Information)
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 🧾 Controllers for editable text fields
  final TextEditingController _nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController _emailController =
      TextEditingController(text: "john.doe@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+63 912 345 6789");
  final TextEditingController _locationController =
      TextEditingController(text: "Naval, Biliran");

  bool _isEditing = false; // Toggles edit mode

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
              if (_isEditing) {
                // When saving changes
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              setState(() {
                _isEditing = !_isEditing;
              });
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
                    _nameController.text,
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
              isEditable: _isEditing,
            ),
            _editableField(
              label: "Phone Number",
              controller: _phoneController,
              icon: Icons.phone_outlined,
              isEditable: _isEditing,
            ),
            _editableField(
              label: "Location",
              controller: _locationController,
              icon: Icons.location_on_outlined,
              isEditable: _isEditing,
            ),

            const SizedBox(height: 30),

            // -------------------------------------------------------
            // ⚙️ SETTINGS SECTION
            // -------------------------------------------------------
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.lock_outline, color: AppColors.primary),
              title: const Text("Change Password"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Change password feature coming soon!"),
                  ),
                );
              },
            ),

            const Divider(height: 30),

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
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
        enabled: isEditable, // ✅ Only editable in edit mode
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.text,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.primary),
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.muted),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
