import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/reverb_nav_bar.dart';

class ChatUser {
  final String name;
  final String image;
  final String lastMessage;
  final bool online;

  const ChatUser({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.online,
  });
}

class GroupChat {
  final String name;
  final String image;
  final String lastMessage;

  const GroupChat({
    required this.name,
    required this.image,
    required this.lastMessage,
  });
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChatUser> matches = [
      const ChatUser(name: "Akshit", image: "assets/user1.jpg", lastMessage: "How are you?", online: true),
      const ChatUser(name: "Ayush", image: "assets/user2.jpg", lastMessage: "Let's meet!", online: true),
      const ChatUser(name: "Veer", image: "assets/user3.jpg", lastMessage: "Cool!", online: false),
      const ChatUser(name: "Paxton", image: "assets/user4.jpg", lastMessage: "Haha, nice!", online: false),
    ];

    final List<ChatUser> chats = [
      const ChatUser(name: "Akshit", image: "assets/user1.jpg", lastMessage: "How are you?", online: true),
      const ChatUser(name: "Ayush", image: "assets/user2.jpg", lastMessage: "Let's meet!", online: false),
      const ChatUser(name: "Veer", image: "assets/user3.jpg", lastMessage: "Cool!", online: false),
    ];

    final List<GroupChat> groupChats = [
      const GroupChat(name: "Concert Squad", image: "assets/travis_event.jpg", lastMessage: "See you there!"),
      const GroupChat(name: "Music Lovers", image: "assets/armaan_event.jpg", lastMessage: "Playlist updated!"),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Use image as background
          Positioned.fill(
            child: Image.asset(
              'assets/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                const SizedBox(height: 18),
                // Matches row
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Matches",
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    scrollDirection: Axis.horizontal,
                    itemCount: matches.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, idx) {
                      if (idx < matches.length) {
                        final user = matches[idx];
                        return Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: AssetImage(user.image),
                                ),
                                if (user.online)
                                  Positioned(
                                    top: 5, right: 5,
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        border: Border.all(color: Colors.white, width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(user.name,
                                style: const TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        );
                      } else {
                        // Arrow for more matches
                        return const Center(
                          child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 26),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Chats
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Chats",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...chats.map((user) => _buildChatTile(context, user)).toList(),

                // Group Chats section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
                  child: Text(
                    "GroupChats",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...groupChats.map((grp) => _buildGroupChatTile(context, grp)).toList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 3),
    );
  }

  static Widget _buildChatTile(BuildContext context, ChatUser user) {
    return GestureDetector(
      onTap: () {
        context.go('/chat/${user.name}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage(user.image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.lastMessage,
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 17),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildGroupChatTile(BuildContext context, GroupChat grp) {
    return GestureDetector(
      onTap: () {
        context.go('/groupchat/${grp.name}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.16),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage(grp.image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grp.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    grp.lastMessage,
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 17),
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