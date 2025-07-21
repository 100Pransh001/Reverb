import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/indicator_dot.dart';

/// InterestedInScreen: Last onboarding step where user selects preference.
/// Next is only enabled if the user has selected an option (cannot skip).
class InterestedInScreen extends StatefulWidget {
  const InterestedInScreen({super.key});

  @override
  State<InterestedInScreen> createState() => _InterestedInScreenState();
}

class _InterestedInScreenState extends State<InterestedInScreen> {
  String? selectedInterest;

  /// Navigate to next screen (recovery) with selected value
  void _navigateToNext() {
    if (selectedInterest != null) {
      context.go('/recovery');
    }
  }

  /// Go back to age screen
  void _navigateBack() {
    context.go('/age');
  }

  /// UI for each option
  Widget _buildOption(String label) {
    final isSelected = selectedInterest == label;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => setState(() => selectedInterest = label),
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.pinkAccent.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.pinkAccent : Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isSelected
                ? Colors.pinkAccent.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Background image ---
          SizedBox.expand(
            child: Image.asset(
              'assets/recovery_email.png',
              fit: BoxFit.cover,
            ),
          ),
          // --- Dark gradient overlay ---
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // --- Back arrow (top left) ---
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                onPressed: _navigateBack,
                tooltip: 'Back',
              ),
            ),
          ),
          // --- Foreground UI ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  // Title
                  const Text(
                    "Who Are You\nInterested in?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Subtitle
                  const Text(
                    "For a more seamless experience,\nplease specify who you are interested in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Interest options (Men, Women, Everyone)
                  _buildOption('Men'),
                  _buildOption('Women'),
                  _buildOption('Everyone'),
                  const Spacer(),
                  // Progress dots
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: true),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // --- Centered Next arrow button at the bottom ---
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AnimatedOpacity(
                        opacity: selectedInterest != null ? 1 : 0.5,
                        duration: const Duration(milliseconds: 180),
                        child: GestureDetector(
                          onTap: selectedInterest != null ? _navigateToNext : null,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedInterest != null
                                  ? Colors.pinkAccent
                                  : Colors.white24,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}