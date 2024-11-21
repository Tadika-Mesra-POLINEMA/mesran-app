import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Ensure you have this import for navigation
import 'package:mesran_app/utils/themes.dart'; // Import your theme file

class ProfileGroupPage extends StatelessWidget {
  const ProfileGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the group
    const String groupName = "Group Name"; // Replace with actual group name
    const int memberCount = 10; // Replace with actual member count
    final List<Map<String, String>> members = [
      {'name': 'Alice', 'profileImage': 'assets/images/avatar.jpeg'},
      {'name': 'Bob', 'profileImage': 'assets/images/avatar.jpeg'},
      {'name': 'Charlie', 'profileImage': 'assets/images/avatar.jpeg'},
      // Add more members as needed
    ];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Group Profile Section
            CircleAvatar(
              radius: 60, // Size of the profile image
              backgroundImage: AssetImage(
                'assets/images/avatar.png',
              ), // Replace with your group image
            ),
            const SizedBox(height: 16),
            Text(groupName, style: titleOneMedium), // Group Name
            const SizedBox(height: 8),
            Text(
              '$memberCount Anggota',
              style: titleTwoMedium.copyWith(color: neutral40),
            ), // Member Count
            const SizedBox(height: 32),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                style: titleOneRegular, // Apply style to the text
                decoration: InputDecoration(
                  hintText: 'Cari anggota...',
                  hintStyle: titleOneRegular.copyWith(
                      color: neutral40), // Style for hint text
                  prefixIcon: Icon(Icons.search, color: neutralBase),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Member List
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        // Navigate to the member's detail profile
                        context.go('/profile');
                        //context.go('/detailProfile/${member['name']}'); // Replace with your detail profile route
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(member['profileImage']!),
                      ),
                    ),
                    title: Text(member['name']!, style: titleOneMedium),
                    trailing: IconButton(
                      icon: Icon(Icons.chat_bubble_outline, color: primaryBase),
                      onPressed: () {
                        // Navigate to chat with this member
                        context.go(
                            '/detailMessage'); // Replace with your chat route
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
