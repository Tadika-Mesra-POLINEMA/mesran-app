import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          backgroundColor: Colors.transparent,
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
                                Icon(Icons.search,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                const SizedBox(width: 8),
                                Text(
                                  'Cari',
                                  style: TextStyle(
                                    fontFamily: 'SF-Pro-Display',
                                    color: neutral40,
                                    fontSize: 16,
                                  ),
                                ),
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
                        style: titleOneMedium, // Apply your style here
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Grup",
                        style: titleOneMedium, // Apply your style here
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ChatTabContent(),
            Center(child: Text("Tidak ada percakapan grup")),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class ChatTabContent extends StatelessWidget {
  const ChatTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatItem>>(
      future: fetchChatItems(),
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
                    context.go('/profile'); // Navigate to the profile page
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(chat.profileImage),
                  ),
                ),
                title: Text(chat.name,
                    style: titleOneMedium), // Use titleOneMedium style
                subtitle: Text(chat.lastMessage,
                    style: titleTwoMedium), // Use titleTwoMedium style
                trailing: Text(chat.time,
                    style: titleTwoMedium.copyWith(
                        color:
                            Colors.grey)), // Use titleTwoMedium style for time
                onTap: () {
                  context
                      .go('/detailmessage'); // Navigate to detail message page
                },
              );
            },
          );
        }
      },
    );
  }

  Future<List<ChatItem>> fetchChatItems() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      ChatItem(
        profileImage: 'assets/images/profile1.png',
        name: 'John Doe',
        lastMessage: 'Hey, how are you?',
        time: '10:30 AM',
      ),
      ChatItem(
        profileImage: 'assets/images/profile2.png',
        name: 'Jane Smith',
        lastMessage: 'See you later!',
        time: '09:15 AM',
      ),
    ];
  }
}

class ChatItem {
  final String profileImage;
  final String name;
  final String lastMessage;
  final String time;

  ChatItem({
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
}
