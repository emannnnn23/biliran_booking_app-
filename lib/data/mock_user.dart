// lib/data/mock_users.dart
// -------------------------------------------------------
// MOCK USER DATA for Signup, Login, and OTP Verification
// + Extended for Client Information (frontend only)
// -------------------------------------------------------

import 'package:flutter/foundation.dart';

class MockUser {
  final String email;
  final String password;
  final String role; // 'Client' or 'Service Provider'
  bool isVerified;

  // 🔹 Optional fields (filled after verification or info form)
  String? firstName;
  String? middleInitial;
  String? lastName;
  String? barangay;
  String? municipality;
  String? fullAddress;
  int? age;
  String? phoneNumber;
  String? validId; // filename or uploaded ID path

  List<String>? preferences; // client preferences for recommendation
  String? location; // deprecated — use barangay + municipality instead

  MockUser({
    required this.email,
    required this.password,
    required this.role,
    this.isVerified = false,
    this.firstName,
    this.middleInitial,
    this.lastName,
    this.barangay,
    this.municipality,
    this.fullAddress,
    this.age,
    this.phoneNumber,
    this.validId,
    this.preferences,
    this.location,
  });
}

// -------------------------------------------------------
// 🔹 In-memory mock database
// -------------------------------------------------------
List<MockUser> mockUsers = [
  MockUser(
    email: 'client@example.com',
    password: '123456',
    role: 'Client',
    isVerified: true,
    firstName: 'Maria',
    lastName: 'Santos',
    barangay: 'Larrazabal',
    municipality: 'Naval',
    fullAddress: 'Larrazabal, Naval, Biliran',
    age: 25,
    phoneNumber: '09123456789',
    validId: 'maria_id.png',
    preferences: ['Photography', 'Catering'],
  ),
  MockUser(
    email: 'provider@example.com',
    password: '123456',
    role: 'Service Provider',
    isVerified: true,
    firstName: 'John',
    lastName: 'Dela Cruz',
  ),
];

// -------------------------------------------------------
// 🧩 Helper: Find user safely (prevents crashes)
// -------------------------------------------------------
MockUser? _findUser(String email) {
  try {
    return mockUsers.firstWhere((u) => u.email == email);
  } catch (e) {
    debugPrint('⚠️ User not found for email: $email');
    return null;
  }
}

// -------------------------------------------------------
// 🔹 Add new user (Signup)
// -------------------------------------------------------
bool addMockUser(String email, String password, String role) {
  final exists = mockUsers.any((u) => u.email == email);
  if (exists) return false;

  mockUsers.add(MockUser(
    email: email,
    password: password,
    role: role,
    isVerified: false,
  ));
  return true;
}

// -------------------------------------------------------
// 🔹 Verify account (mark as verified)
// -------------------------------------------------------
void verifyMockUser(String email) {
  final user = _findUser(email);
  if (user != null) user.isVerified = true;
}

// -------------------------------------------------------
// 🔹 Authenticate (Login)
// -------------------------------------------------------
MockUser? authenticateUser(String email, String password) {
  final user = _findUser(email);
  if (user != null && user.password == password) {
    return user;
  }
  return null;
}

// -------------------------------------------------------
// 🔹 Update Client Preferences (for recommendation system)
// -------------------------------------------------------
void updateClientPreferences(String email, List<String> prefs) {
  final user = _findUser(email);
  if (user != null) {
    user.preferences = prefs;
    debugPrint('✅ Preferences updated for $email: ${prefs.join(", ")}');
  } else {
    debugPrint('⚠️ Could not update preferences — user not found: $email');
  }
}

// -------------------------------------------------------
// 🔹 Update Client Information (for new info form page)
// -------------------------------------------------------
void updateClientInfo(String email, Map<String, dynamic> info) {
  final user = _findUser(email);
  if (user == null) {
    debugPrint('⚠️ Could not update client info — user not found: $email');
    return;
  }

  user.firstName = info['firstName'];
  user.middleInitial = info['middleInitial'];
  user.lastName = info['lastName'];
  user.barangay = info['barangay'];
  user.municipality = info['municipality'];
  user.fullAddress = info['fullAddress'];
  user.age = info['age'];
  user.phoneNumber = info['phoneNumber'];
  user.validId = info['validId'];

  debugPrint('✅ Client info updated for $email');
}

// -------------------------------------------------------
// 🔹 Debug Helper: Print all mock users (for testing)
// -------------------------------------------------------
void debugPrintUsers() {
  debugPrint('📋 MOCK USERS:');
  for (var u in mockUsers) {
    debugPrint(
      '👤 ${u.email} | Verified: ${u.isVerified} | '
      'Name: ${u.firstName ?? "-"} ${u.lastName ?? "-"} | '
      'Municipality: ${u.municipality ?? "-"} | Prefs: ${u.preferences ?? []}',
    );
  }
}
