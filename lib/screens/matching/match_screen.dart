import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchScreen extends StatelessWidget {
  final String myImagePath;
  final String otherImagePath;

  const MatchScreen({
    Key? key,
    required this.myImagePath,
    required this.otherImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sizes for big circles and heart
    const double avatarRadius = 110;
    const double heartRadius = 44;

    return Scaffold(
      // Use Stack to set background image and overlay everything
      body: Stack(
        children: [
          // 🎨 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/match_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button (top-left)
          SafeArea(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 32),
              onPressed: () {
                context.go('/likes'); // GoRouter navigation to swipe profiles
              },
            ),
          ),
          // Main content
          Center(
            child: Column(
              children: [
                const SizedBox(height: 54),
                const Text(
                  "It's a Match <3",
                  style: TextStyle(
                    fontFamily: 'Montserrat', // Or your custom font
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 48),
                // 🟣 Avatars and Heart
                SizedBox(
                  width: 390,
                  height: 315,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // My avatar (top left)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: AssetImage(myImagePath),
                        ),
                      ),
                      // Other avatar (bottom right)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: AssetImage(otherImagePath),
                        ),
                      ),
                      // Heart in the middle
                      Positioned(
                        left: 128,
                        top: 106,
                        child: CircleAvatar(
                          radius: heartRadius,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite_border, color: Colors.red, size: 40),
                        ),
                      ),
                    ],
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