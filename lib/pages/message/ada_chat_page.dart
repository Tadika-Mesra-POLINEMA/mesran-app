import 'package:flutter/material.dart';
import 'package:mesran_app/components/bottom_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class AdaChatPage extends StatelessWidget {
  const AdaChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Pesan', style: headingTwoSemiBold),
                InkWell(
                  onTap: () => context.push('/notifications'),
                  child: bell.copyWith(color: neutralBase),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => print('Tombol Cari ditekan!'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: neutralBase),
                                const SizedBox(width: 8),
                                Text('Cari',
                                    style: titleOneRegular.copyWith(
                                        color: neutral40)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  indicatorColor: primaryBase,
                  labelColor: primaryBase,
                  unselectedLabelColor: neutral40,
                  tabs: [
                    Tab(
                      child: Text(
                        "Pribadi",
                        style: titleOneMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Grup",
                        style: titleOneMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Set the body background color to white
        body: Container(
          color: Colors.white, // Set the background color of the body
          child: const TabBarView(
            children: [
              ChatTabContent(isGroupChat: false), // Personal chat
              ChatTabContent(isGroupChat: true), // Group chat
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class ChatTabContent extends StatelessWidget {
  final bool isGroupChat;

  const ChatTabContent({super.key, required this.isGroupChat});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatItem>>(
      future: fetchChatItems(isGroupChat),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No chats available.'));
        } else {
          final chats = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: GestureDetector(
                  onTap: () {
                    if (isGroupChat) {
                      context.go('/profileGroup');
                    } else {
                      context.go('/profile');
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(chat.profileImage),
                  ),
                ),
                title: Text(chat.name, style: titleOneMedium),
                subtitle: Text(chat.lastMessage,
                    style: titleTwoRegular.copyWith(color: neutral40)),
                trailing: Text(chat.time,
                    style: titleTwoMedium.copyWith(color: neutral40)),
                onTap: () {
                  if (isGroupChat) {
                    context.go('/detailMessageGroup');
                  } else {
                    context.go('/detailMessage');
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  Future<List<ChatItem>> fetchChatItems(bool isGroupChat) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    if (isGroupChat) {
      return [
        ChatItem(
          id: 'group1',
          profileImage: 'assets/images/avatar.jpeg',
          name: 'Group Chat 1',
          lastMessage: 'Hello everyone!',
          time: '10:00 AM',
        ),
        ChatItem(
          id: 'group2',
          profileImage: 'assets/images/avatar.jpeg',
          name: 'Group Chat 2',
          lastMessage: 'Let’s meet at 5 PM.',
          time: '08:30 AM',
        ),
      ];
    } else {
      return [
        ChatItem(
          id: 'user1',
          profileImage: 'assets/images/avatar.jpeg',
          name: 'John Doe',
          lastMessage: 'Hey, how are you?',
          time: '10:30 AM',
        ),
        ChatItem(
          id: 'user2',
          profileImage: 'assets/images/avatar.jpeg',
          name: 'Jane Smith',
          lastMessage: 'See you later!',
          time: '09:15 AM',
        ),
      ];
    }
  }
}

class ChatItem {
  final String id;
  final String profileImage;
  final String name;
  final String lastMessage;
  final String time;

  ChatItem({
    required this.id,
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
}
