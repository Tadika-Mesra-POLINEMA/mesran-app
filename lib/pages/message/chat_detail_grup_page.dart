import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/themes.dart';

class GroupChatDetailPage extends StatelessWidget {
  final String groupName = "Group Chat Name";
  final int memberCount = 5;
  final String currentUserName = "You";

  // Sample messages with profile images and read status
  final List<Map<String, dynamic>> messages = [
    {
      'sender': 'Alice',
      'text': 'Lagi apa, dan?',
      'profileImage': 'assets/images/avatar.jpeg',
      'isRead': true
    },
    {
      'sender': 'Bob',
      'text': 'Ayo nobar timnas',
      'profileImage': 'assets/images/avatar.jpeg',
      'isRead': true
    },
    {
      'sender': 'me',
      'text': 'Lagi gabut',
      'profileImage': 'assets/images/avatar.jpeg',
      'isRead': true
    },
    {
      'sender': 'me',
      'text': 'Gas nobar timnas. Dimana emang?',
      'profileImage': 'assets/images/avatar.jpeg',
      'isRead': false // Mark as not read
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.go('/adamessage');
              },
              child: Icon(Icons.chevron_left, color: Colors.black),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groupName, style: titleOneMedium),
                Text('$memberCount Anggota',
                    style: titleTwoMedium.copyWith(color: neutral40)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // Set the body background to white
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                  final isRead = message['isRead'] ?? false;

                  return Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        CircleAvatar(
                          backgroundImage: AssetImage(message['profileImage']),
                        ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isMe ? primaryBase : neutral10,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isMe ? 'Anda' : message['sender'],
                                  style: paragraphOneNotBold.copyWith(
                                    color: isMe ? Colors.white : primaryBase,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  message['text']!,
                                  style: titleOneRegular.copyWith(
                                    height: 1.2,
                                    color: isMe ? Colors.white : neutralBase,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          if (isMe) // Show read indicator for user's own messages
                            Row(
                              children: [
                                Icon(
                                  isRead
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  color: isRead ? Colors.blue : Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isRead ? 'Read' : 'Sent',
                                  style: TextStyle(
                                    color: isRead ? Colors.blue : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                        ],
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
                          color: neutral40,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
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
                          context.go('/nextPage');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
