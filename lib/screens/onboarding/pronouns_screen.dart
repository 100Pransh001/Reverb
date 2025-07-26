import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

class PronounsScreen extends StatefulWidget {
  final String? displayName;
  final String? recoveryEmail;
  final List<String>? photos;
  final List<String>? interests;

  const PronounsScreen({
    Key? key,
    this.displayName,
    this.recoveryEmail,
    this.photos,
    this.interests,
  }) : super(key: key);

  @override
  State<PronounsScreen> createState() => _PronounsScreenState();
}

class _PronounsScreenState extends State<PronounsScreen> {
  final TextEditingController _pronounsController = TextEditingController();

  void _navigateNext() {
    final pronouns = _pronounsController.text.trim();
    // Forward all collected data + pronouns
    context.go('/bio', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
      'pronouns': pronouns,
    });
  }

  void _navigateBack() {
    // Go back to InterestsScreen, pass all data (except pronouns)
    context.go('/interests', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/pronouns_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
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
          // Foreground UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 28),
                      onPressed: _navigateBack,
                      tooltip: 'Back',
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Heading
                  const Text(
                    "Enter your\nPronouns",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtext
                  const Text(
                    "Add pronouns to display them on\nyour profile",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Input Field
                  TextField(
                    controller: _pronounsController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.pinkAccent,
                    decoration: InputDecoration(
                      hintText: 'Pronouns',
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Progress Indicators
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: true), // 5th step
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Next button (arrow)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: _navigateNext,
                      child: Container(
                        width: 60,
                        height: 60,
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
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}