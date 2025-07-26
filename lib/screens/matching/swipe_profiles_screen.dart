import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../ widgets/reverb_nav_bar.dart';
import 'match_screen.dart';
import 'friendly_match_screen.dart'; // You must create this file as above

class UserProfile {
  final String name;
  final int age;
  final double distance;
  final String imagePath;
  final List<String> interests;

  UserProfile({
    required this.name,
    required this.age,
    required this.distance,
    required this.imagePath,
    required this.interests,
  });
}

class SwipeProfilesScreen extends StatefulWidget {
  const SwipeProfilesScreen({Key? key}) : super(key: key);

  @override
  State<SwipeProfilesScreen> createState() => _SwipeProfilesScreenState();
}

class _SwipeProfilesScreenState extends State<SwipeProfilesScreen> {
  late MatchEngine _matchEngine;

  final List<UserProfile> profiles = [
    UserProfile(
      name: 'A',
      age: 22,
      distance: 19,
      imagePath: 'assets/user1.jpg',
      interests: ['Hip-Hop', 'Poetry', 'Movies'],
    ),
    UserProfile(
      name: 'B',
      age: 23,
      distance: 12,
      imagePath: 'assets/user2.jpg',
      interests: ['Jazz', 'Coding', 'Gaming'],
    ),
    // Add more mock users here!
  ];

  @override
  void initState() {
    super.initState();
    _matchEngine = MatchEngine(
      swipeItems: profiles.map((profile) => SwipeItem(content: profile)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // BG image
          SizedBox.expand(
            child: Image.asset(
              'assets/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Expanded(
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      return _buildProfileCard(context, profile);
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No more profiles!")),
                      );
                    },
                    upSwipeAllowed: false,
                    fillSpace: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 2),
    );
  }

  Widget _buildProfileCard(BuildContext context, UserProfile profile) {
    return Stack(
      children: [
        // Card BG
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 18, offset: Offset(0, 6))
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 36),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(profile.imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          ),
        ),
        // Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Top X
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 2 - 36,
          child: CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(Icons.close, size: 40, color: Colors.black),
          ),
        ),
        // 👥 Friends Button (left bottom) - TAP TO FRIENDLY MATCH!
        Positioned(
          left: 24,
          bottom: 36,
          child: GestureDetector(
            onTap: () {
              // GoRouter navigation with .extra for data
              context.push('/friendly-match', extra: {
                'myImagePath': 'assets/my_profile.jpg',
                'otherImagePath': profile.imagePath,
              });
            },
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              child: Icon(Icons.people, size: 34, color: Colors.black),
            ),
          ),
        ),
        // ❤️ Like Button (right bottom) - TAP TO MATCH!
        Positioned(
          right: 24,
          bottom: 36,
          child: GestureDetector(
            onTap: () {
              // GoRouter navigation with .extra for data
              context.push('/match', extra: {
                'myImagePath': 'assets/my_profile.jpg',
                'otherImagePath': profile.imagePath,
              });
            },
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite_border, color: Colors.red, size: 38),
            ),
          ),
        ),
        // Profile details (bottom center above buttons)
        Positioned(
          left: 0,
          right: 0,
          bottom: 110,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profile.name}, ${profile.age}",
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("${profile.distance} Km Away", style: const TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(height: 12),
                Row(
                  children: profile.interests.map((e) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(e, style: const TextStyle(color: Colors.white, fontSize: 15)),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}