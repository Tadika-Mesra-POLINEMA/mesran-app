import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Ensure you have this import for navigation
import 'package:mesran_app/utils/themes.dart'; // Import your theme file

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.go('/adamessage'); // Navigate to /message
              },
              child: Icon(Icons.chevron_left, color: Colors.black),
            ),
            const SizedBox(width: 8), // Add some spacing between icon and text
            Text(
              'Profile',
              style: headingTwoSemiBold,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Photo
            CircleAvatar(
              radius: 60, // Size of the profile image
              backgroundImage: AssetImage(
                  'assets/images/avatar.png'), // Replace with your image
            ),
            const SizedBox(height: 16),
            // Name
            Text('Maul Gokil 86', // Replace with dynamic name if needed
                style: titleOneMedium),
            const SizedBox(height: 8),
            // Phone Number
            Text(
                "+62 812-3456-7890", // Replace with dynamic phone number if needed
                style: titleTwoMedium),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
