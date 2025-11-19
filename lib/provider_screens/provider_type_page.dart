import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderTypeSelectionPage extends StatelessWidget {
  const ProviderTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final email = args?['email'];

    void _selectType(String type) {
      // Save provider type to mockUsers
      final user = mockUsers.firstWhere((u) => u.email == email);
      user.serviceType = type;

      Navigator.pushReplacementNamed(
        context,
        '/provider/setup_${type}',
        arguments: {'email': email},
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Provider Type"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What type of services do you offer?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _optionButton(
              icon: Icons.calendar_today_outlined,
              title: "Booking Services Only",
              subtitle: "Photography, Catering, Makeup, Band, etc.",
              onTap: () => _selectType("booking"),
            ),

            _optionButton(
              icon: Icons.shopping_bag_outlined,
              title: "Selling Products Only",
              subtitle: "Flowers, Balloons, Souvenirs, Party Needs, etc.",
              onTap: () => _selectType("selling"),
            ),

            _optionButton(
              icon: Icons.all_inclusive,
              title: "Both (Booking + Selling)",
              subtitle: "Event Stylists, Florists, etc.",
              onTap: () => _selectType("both"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, size: 32, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
