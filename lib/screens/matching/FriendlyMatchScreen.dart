import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendlyMatchLoadingScreen extends StatefulWidget {
  const FriendlyMatchLoadingScreen({Key? key}) : super(key: key);

  @override
  State<FriendlyMatchLoadingScreen> createState() => _FriendlyMatchLoadingScreenState();
}

class _FriendlyMatchLoadingScreenState extends State<FriendlyMatchLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go('/found-match');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // --- Background Gradient Image ---
          Positioned.fill(
            child: Image.asset(
              'assets/bg_gradient_match.png',
              fit: BoxFit.cover,
            ),
          ),
          // --- Loader and Text ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: Colors.purpleAccent),
                SizedBox(height: 24),
                Text(
                  "Finding a Friend Match...",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
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