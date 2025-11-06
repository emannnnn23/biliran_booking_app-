// lib/data/mock_users.dart
// -------------------------------------------------------
// MOCK USER DATA for Signup, Login, and OTP Verification
// -------------------------------------------------------

class MockUser {
  final String email;
  final String password;
  final String role; // 'Client' or 'Service Provider'
  bool isVerified;
  List<String>? preferences; // for client
  String? location; // for client

  MockUser({
    required this.email,
    required this.password,
    required this.role,
    this.isVerified = false,
    this.preferences,
    this.location,
  });
}

// 🔹 In-memory mock user list (temporary database)
List<MockUser> mockUsers = [
  MockUser(
    email: 'client@example.com',
    password: '123456',
    role: 'Client',
    isVerified: true,
    preferences: ['Photography', 'Catering'],
    location: 'Naval, Biliran',
  ),
  MockUser(
    email: 'provider@example.com',
    password: '123456',
    role: 'Service Provider',
    isVerified: true,
  ),
];

// 🔹 Add new user
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

// 🔹 Verify account
void verifyMockUser(String email) {
  final user = mockUsers.firstWhere((u) => u.email == email);
  user.isVerified = true;
}

// 🔹 Authenticate (Login)
MockUser? authenticateUser(String email, String password) {
  try {
    final user = mockUsers.firstWhere((u) => u.email == email);
    if (user.password == password) return user;
  } catch (e) {
    return null;
  }
  return null;
}

// 🔹 Update client preferences
void updateClientPreferences(String email, List<String> prefs) {
  final user = mockUsers.firstWhere((u) => u.email == email);
  user.preferences = prefs;
}

// 🔹 Update client location
void updateClientLocation(String email, String location) {
  final user = mockUsers.firstWhere((u) => u.email == email);
  user.location = location;
}
