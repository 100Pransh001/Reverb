import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import your reusable indicator dot if in separate file
import '../../ widgets/indicator_dot.dart';

class BioScreen extends StatefulWidget {
  final String? displayName;
  final String? recoveryEmail;
  final List<String>? photos;
  final List<String>? interests;
  final String? pronouns;

  const BioScreen({
    Key? key,
    this.displayName,
    this.recoveryEmail,
    this.photos,
    this.interests,
    this.pronouns,
  }) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  /// Navigates to next step, passes all collected data using GoRouter.
  void _navigateNext() {
    final bio = _bioController.text.trim();
    context.go('/genres', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
      'pronouns': widget.pronouns,
      'bio': bio,
    });
  }

  /// Optional: Back navigation (customize as per your flow)
  void _navigateBack() {
    context.go('/pronouns', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
      'pronouns': widget.pronouns,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/bio_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
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
                      onPressed: _navigateBack,
                      tooltip: 'Back',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Heading
                  const Text(
                    "Add an\nInteresting Bio",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtext
                  const Text(
                    "Don’t be shy! Show off your personality\nwith a good bio",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Bio input
                  TextField(
                    controller: _bioController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.pinkAccent,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Bio',
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Page indicators (show correct step)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: true), // You can adjust which dot is active
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Next button (arrow style)
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