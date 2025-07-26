import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

class LookingForScreen extends StatelessWidget {
  final String? displayName;
  final String? recoveryEmail;
  final List<String>? photos;
  final List<String>? interests;
  final String? pronouns;
  final String? bio;
  final List<String>? genres;

  const LookingForScreen({
    Key? key,
    this.displayName,
    this.recoveryEmail,
    this.photos,
    this.interests,
    this.pronouns,
    this.bio,
    this.genres,
  }) : super(key: key);

  void _onOptionSelected(BuildContext context, String choice) {
    // Forward all data + user choice for next steps
    context.go('/home', extra: {
      'displayName': displayName,
      'recoveryEmail': recoveryEmail,
      'photos': photos,
      'interests': interests,
      'pronouns': pronouns,
      'bio': bio,
      'genres': genres,
      'lookingFor': choice,
    });
  }

  void _navigateBack(BuildContext context) {
    context.go('/genres', extra: {
      'displayName': displayName,
      'recoveryEmail': recoveryEmail,
      'photos': photos,
      'interests': interests,
      'pronouns': pronouns,
      'bio': bio,
      'genres': genres,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/looking_for_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                      onPressed: () => _navigateBack(context),
                      tooltip: 'Back',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title & subtitle
                  const Text(
                    "What are you\nlooking for?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What brings you here? Select for a\npersonalised experience.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Option buttons
                  _buildOptionButton(context, "Blind Date"),
                  const SizedBox(height: 20),
                  _buildOptionButton(context, "Friends"),
                  const SizedBox(height: 20),
                  _buildOptionButton(context, "Both"),
                  const Spacer(),

                  // Page indicators and Next button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page indicators
                      const Row(
                        children: [
                          IndicatorDot(active: false),
                          IndicatorDot(active: false),
                          IndicatorDot(active: false),
                          IndicatorDot(active: false),
                          IndicatorDot(active: false),
                          IndicatorDot(active: true), // 6th
                        ],
                      ),
                      // Next button
                      GestureDetector(
                        onTap: () => _onOptionSelected(context, "Both"),
                        child: Container(
                          width: 52,
                          height: 52,
                          margin: const EdgeInsets.only(left: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pinkAccent,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String text) {
    return InkWell(
      onTap: () => _onOptionSelected(context, text),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}