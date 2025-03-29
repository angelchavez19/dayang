import 'package:flutter/material.dart';

class AppAboutView extends StatelessWidget {
  const AppAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoTile(Icons.person, "Developer", "Angel Chávez"),
          _buildInfoTile(Icons.brush, "Designer", "Dayanara Costa"),
          _buildInfoTile(Icons.email, "Support", "infoangelchavez@gmail.com"),
          _buildInfoTile(Icons.info, "App Version", "1.0.0"),
          _buildInfoTile(Icons.code, "Made with", "Flutter & Dart"),
          const SizedBox(height: 20),
          const Text(
            "This app is designed to help you manage your finances efficiently.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }
}
