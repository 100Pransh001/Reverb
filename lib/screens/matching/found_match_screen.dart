import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoundMatchScreen extends StatelessWidget {
  const FoundMatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient background image
          Positioned.fill(
            child: Image.asset(
              'assets/bg_gradient_match.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heart image
                Image.asset(
                  'assets/heart_pixel.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Found a Match!!",
                  style: TextStyle(
                    color: Color(0xFF580A46),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF580A46),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  onPressed: () {
                    context.go('/chats');
                  },
                  child: const Text(
                    "Continue to chat",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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