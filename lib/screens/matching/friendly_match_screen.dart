import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendlyMatchScreen extends StatelessWidget {
  final String myImagePath;
  final String otherImagePath;

  const FriendlyMatchScreen({
    Key? key,
    required this.myImagePath,
    required this.otherImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sizes for big circles and icon, matching your reference
    const double avatarRadius = 110;
    const double iconRadius = 44;

    return Scaffold(
      body: Stack(
        children: [
          // 🎨 Friendly Match Background
          Positioned.fill(
            child: Image.asset(
              'assets/friendmatch_bg.png', // Make sure this matches your asset path!
              fit: BoxFit.cover,
            ),
          ),
          // Back button (top-left)
          SafeArea(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 32),
              onPressed: () {
                context.go('/likes');
              },
            ),
          ),
          // Main Content
          Center(
            child: Column(
              children: [
                const SizedBox(height: 54),
                const Text(
                  "It's a Friendly\nMatch!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: 390,
                  height: 315,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // My avatar (bottom left)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: AssetImage(myImagePath),
                        ),
                      ),
                      // Other avatar (top right)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: AssetImage(otherImagePath),
                        ),
                      ),
                      // Friends icon in the middle
                      Positioned(
                        left: 128,
                        top: 106,
                        child: CircleAvatar(
                          radius: iconRadius,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.people, color: Colors.black, size: 40),
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