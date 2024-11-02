import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/themes.dart'; // Import your theme file

class ChatDetailPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {'sender': 'other', 'text': 'Lagi apa, dan?'},
    {'sender': 'other', 'text': 'Ayo nobar timnas'},
    {'sender': 'me', 'text': 'Lagi gabut'},
    {'sender': 'me', 'text': 'Gas nobar timnas. Dimana emang?'},
  ];

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
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(width: 8),
            Text("Maul Gokil 86", style: titleOneMedium),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Center(
            child: Container(
              width: 343,
              height: 14,
              child: Text(
                "HARI INI",
                style: titleThreeMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message['sender'] == 'me';

                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isMe ? primaryBase : neutral10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        message['text']!,
                        style: titleOneRegular.copyWith(
                          height: 1.2, // Set line height
                          color: isMe
                              ? Colors.white
                              : neutralBase, // Set color based on condition
                        ),
                        textAlign: TextAlign.left, // Left align the text
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ketik disini',
                      hintStyle: titleOneRegular.copyWith(
                        // Use copyWith to customize the hint style
                        color: neutral40, // Set the color for the hint text
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none, // No border
                      ),
                      fillColor: Colors.grey[200], // Background color
                      filled: true, // Fill the background
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Transform.rotate(
                  angle: 90 * (3.1415927 / 180),
                  child: CircleAvatar(
                    backgroundColor: primaryBase,
                    child: IconButton(
                      icon: Icon(Icons.navigation, color: Colors.white),
                      onPressed: () {
                        context.go('/nextPage'); // Navigate to the next page
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
