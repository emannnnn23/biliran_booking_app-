// lib/data/mock_users.dart
// -------------------------------------------------------
// MOCK USER DATA for Signup, Login, OTP Verification,
// Client Information, and Provider Information
// -------------------------------------------------------

import 'package:flutter/foundation.dart';

class MockUser {
  final String email;
  final String password;
  final String role; // 'Client' or 'Service Provider'
  bool isVerified; // OTP verified

  // -------------------------------------------------------
  // PROVIDER FIELDS
  // -------------------------------------------------------
  String serviceType; // booking | selling | both
  String? businessName;
  String? businessId; // NEW ✔ Business ID file path
  List<String>? bookingServices = [] ;  // e.g., Photography, Catering
  List<String>? sellingProducts = [];    // e.g., Flowers, Balloons


  // -------------------------------------------------------
  // CLIENT FIELDS
  // -------------------------------------------------------
  String? firstName;
  String? middleInitial;
  String? lastName;

  String? barangay;
  String? municipality;
  String? fullAddress;

  int? age;
  String? phoneNumber;

  bool phoneVerified; // replaces valid ID workflow

  List<String>? preferences; // for recommendation system
  String? location; // deprecated

  // -------------------------------------------------------
  // CONSTRUCTOR
  // -------------------------------------------------------
  MockUser({
    required this.email,
    required this.password,
    required this.role,
    this.isVerified = false,

    // Provider defaults
    this.serviceType = "booking",
    this.bookingServices,
    this.sellingProducts,

    this.businessName,
    this.businessId, // NEW ✔

    // Client// and provider shared fields
    this.firstName,
    this.middleInitial,
    this.lastName,
    this.barangay,
    this.municipality,
    this.fullAddress,
    this.age,
    this.phoneNumber,
   //client default
    this.phoneVerified = false,
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
    phoneVerified: true,
    preferences: ['Photography', 'Catering'],
  ),

  MockUser(
    email: 'provider@example.com',
    password: '123456',
    role: 'Service Provider',
    isVerified: true,
    firstName: 'John',
    lastName: 'Dela Cruz',
    businessName: 'John Studio',
    businessId: 'mock_uploads/john_business_id.png', // example ✔
  ),
];

// -------------------------------------------------------
// 🧩 Helper — safe lookup
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

  mockUsers.add(
    MockUser(
      email: email,
      password: password,
      role: role,
      isVerified: false,
    ),
  );
  return true;
}

// -------------------------------------------------------
// 🔹 Verify account (OTP)
// -------------------------------------------------------
void verifyMockUser(String email) {
  final user = _findUser(email);
  if (user != null) user.isVerified = true;
}

// -------------------------------------------------------
// 🔹 Authenticate Login
// -------------------------------------------------------
MockUser? authenticateUser(String email, String password) {
  final user = _findUser(email);
  if (user != null && user.password == password) {
    return user;
  }
  return null;
}

// -------------------------------------------------------
// 🔹 Update Client Preferences
// -------------------------------------------------------
void updateClientPreferences(String email, List<String> prefs) {
  final user = _findUser(email);
  if (user != null) {
    user.preferences = prefs;
    debugPrint('✅ Preferences updated for $email: ${prefs.join(", ")}');
  }
}

// -------------------------------------------------------
// 🔹 Update Client Information
// -------------------------------------------------------
void updateClientInfo(String email, Map<String, dynamic> info) {
  final user = _findUser(email);
  if (user == null) return;

  user.firstName = info['firstName'];
  user.middleInitial = info['middleInitial'];
  user.lastName = info['lastName'];
  user.barangay = info['barangay'];
  user.municipality = info['municipality'];
  user.fullAddress = info['fullAddress'];
  user.age = info['age'];
  user.phoneNumber = info['phoneNumber'];
  user.phoneVerified = true;

  debugPrint('✅ Client info updated for $email');
}

// -------------------------------------------------------
// 🔹 Debug Helper
// -------------------------------------------------------
void debugPrintUsers() {
  debugPrint('📋 MOCK USERS:');
  for (var u in mockUsers) {
    debugPrint(
      '👤 ${u.email} | BusinessID: ${u.businessId ?? "None"} | OTP: ${u.isVerified}',
    );
  }
}
