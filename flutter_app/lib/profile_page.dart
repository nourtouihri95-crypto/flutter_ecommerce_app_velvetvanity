import 'package:flutter/material.dart';
import 'brand_logo.dart';
import 'main.dart'; // pour LoginPage (logout)

class ProfilePage extends StatelessWidget {
  final String fullname;
  final String role;
  final String email;

  const ProfilePage({
    super.key,
    required this.fullname,
    required this.role,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BrandLogo(size: 100),
            const SizedBox(height: 20),

            // 👤 NOM
            Text(
              fullname,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // 📧 EMAIL
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 15),

            // 🔴 BADGE ADMIN
            if (role == 'admin')
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ADMIN',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // 🚪 LOGOUT
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



