import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

/// InterestsScreen
/// Lets user select interests, passes all onboarding data to next step.
class InterestsScreen extends StatefulWidget {
  final String? displayName;
  final String? recoveryEmail;
  final List<String>? photos;

  const InterestsScreen({
    Key? key,
    this.displayName,
    this.recoveryEmail,
    this.photos,
  }) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> interests = [
    'Music Enthusiast', 'Movies', 'Cooking', 'Book Nerd',
    'Boating', 'Gambling', 'Video Games', 'Design',
    'Swimming', 'Videography', 'Art', 'Athlete',
  ];
  final Set<String> selectedInterests = {};

  void _toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  /// Navigates to the next screen, passing all collected data.
  void _navigateNext() {
    context.go('/pronouns', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': selectedInterests.toList(),
    });
  }

  /// Optional: Allow going back to MediaScreen with existing data
  void _navigateBack() {
    context.go('/media', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
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
              'assets/interests_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
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
                  // Back button (optional)
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
                    "Interests",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtitle
                  const Text(
                    "Select a few of your interests to match with\nusers who have similar things in common",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Interest tags
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: interests.map((interest) {
                          final isSelected = selectedInterests.contains(interest);
                          return GestureDetector(
                            onTap: () => _toggleInterest(interest),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.pinkAccent : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Text(
                                interest,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Progress indicators (4th step active)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Next button (arrow, bottom right)
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