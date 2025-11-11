// lib/screens/client_information_page.dart
// -------------------------------------------------------
// 🧾 CLIENT INFORMATION FORM PAGE (Replaces Location Page)
// -------------------------------------------------------
// After OTP verification, the client fills in their basic info.
// Data is temporarily stored in mockUsers (frontend DB).
// After submitting, user proceeds to the Preferences Page.
// -------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../data/mock_user.dart';
import '../theme.dart';

class ClientInformationPage extends StatefulWidget {
  const ClientInformationPage({super.key});

  @override
  State<ClientInformationPage> createState() => _ClientInformationPageState();
}

class _ClientInformationPageState extends State<ClientInformationPage> {
  final _formKey = GlobalKey<FormState>();

  // 🧩 Form controllers
  final _firstNameCtrl = TextEditingController();
  final _middleInitialCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _selectedMunicipality;
  String? _selectedBarangay;
  String? _selectedValidID;
  String? _uploadedFileName;
  String? email;

  // 🗺️ Dropdown data (Biliran Province)
  final List<String> _municipalities = [
    'Naval',
    'Biliran',
    'Caibiran',
    'Almeria',
    'Kawayan',
    'Culaba',
    'Maripipi',
    'Cabucgayan',
  ];

  final List<String> _barangays = [
    'Brgy. Agpangi',
    'Brgy. Larrazabal',
    'Brgy. Sto. Niño',
    'Brgy. Atipolo',
    'Brgy. Calumpang',
  ];

  final List<String> _validIDs = [
    'PhilHealth ID',
    'National ID',
    'Driver’s License',
    'Voter’s ID',
    'Passport',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'];
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleInitialCtrl.dispose();
    _lastNameCtrl.dispose();
    _ageCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------
  // 📸 Pick ID Photo using File Picker (Web Safe)
  // -------------------------------------------------------
  Future<void> _pickIDImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.name.isNotEmpty) {
        setState(() {
          _uploadedFileName = result.files.single.name;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ ID image selected: $_uploadedFileName')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to pick image: $e')),
      );
    }
  }

  // -------------------------------------------------------
  // 💾 Save Info → Update mockUsers → Go to Preferences
  // -------------------------------------------------------
  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMunicipality == null || _selectedBarangay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your municipality and barangay.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a valid ID photo.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final info = {
      'firstName': _firstNameCtrl.text.trim(),
      'middleInitial': _middleInitialCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'barangay': _selectedBarangay,
      'municipality': _selectedMunicipality,
      'fullAddress': _addressCtrl.text.trim(),
      'age': int.tryParse(_ageCtrl.text.trim()) ?? 0,
      'phoneNumber': _phoneCtrl.text.trim(),
      'validId': _uploadedFileName,
    };

    // 🧠 Save to mockUsers
    if (email != null) {
      updateClientInfo(email!, info);
      debugPrint('✅ Client info saved for $email');
      debugPrintUsers();
    }

    // 🚀 Navigate to Preferences Page
    Navigator.pushReplacementNamed(
      context,
      '/client/preferences',
      arguments: {'email': email,}
      
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please provide your information:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              // 🧍‍♂️ Personal Info
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter first name' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _middleInitialCtrl,
                decoration: const InputDecoration(labelText: 'Middle Initial (optional)'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter last name' : null,
              ),
              const SizedBox(height: 20),

              // 🎂 Age + Phone
              TextFormField(
                controller: _ageCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your age' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your phone number' : null,
              ),
              const SizedBox(height: 12),

              // 🏠 Municipality + Barangay
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Municipality'),
                value: _selectedMunicipality,
                items: _municipalities
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedMunicipality = value),
                validator: (v) =>
                    v == null ? 'Please select your municipality' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Barangay'),
                value: _selectedBarangay,
                items: _barangays
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedBarangay = value),
                validator: (v) =>
                    v == null ? 'Please select your barangay' : null,
              ),
              const SizedBox(height: 12),

              // 📍 Full Address
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(
                  labelText: 'Full Address (Street, Purok, etc.)',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your full address' : null,
              ),
              const SizedBox(height: 20),

              // 🪪 Valid ID Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Valid ID Type'),
                value: _selectedValidID,
                items: _validIDs
                    .map((id) => DropdownMenuItem(value: id, child: Text(id)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedValidID = value),
                validator: (v) => v == null ? 'Select a valid ID type' : null,
              ),
              const SizedBox(height: 12),

              // 📸 Upload ID Button
              OutlinedButton.icon(
                onPressed: _pickIDImage,
                icon: const Icon(Icons.upload_file),
                label: Text(
                  _uploadedFileName == null
                      ? 'Upload ID Photo'
                      : 'Uploaded: $_uploadedFileName',
                ),
              ),
              const SizedBox(height: 30),

              // ✅ Continue Button
              ElevatedButton(
                onPressed: _saveAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Save and Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
