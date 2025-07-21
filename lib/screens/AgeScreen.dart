import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/indicator_dot.dart';

// --------- Constants for age picker logic ---------
const int kMinAge = 18;
const int kMaxAge = 100;
const int kDefaultAge = 23;

/// 📱 AgeScreen: Lets user select their age for onboarding.
class AgeScreen extends StatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int selectedAge = kDefaultAge;

  /// Navigate to previous (Height) screen
  void _handleBack() {
    context.go('/height');
  }

  /// Navigate to next (InterestedIn) screen, passing the selected age
  void _handleNext() {
    context.go('/interestedin', extra: {'age': selectedAge});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Background image ---
          SizedBox.expand(
            child: Image.asset(
              'assets/age_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // --- 2. Gradient overlay for readability ---
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
          // --- 3. Back arrow (top left corner) ---
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: _handleBack,
                tooltip: 'Back',
              ),
            ),
          ),
          // --- 4. Main foreground content ---
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Title
                const Text(
                  "Enter Your Age",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Subtitle
                const Text(
                  "For a more curated experience,\nplease specify your age",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                // Cupertino-style Age Picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedAge - kMinAge,
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedAge = index + kMinAge;
                      });
                    },
                    children: List.generate(
                      kMaxAge - kMinAge + 1,
                      (index) => Center(
                        child: Text(
                          '${index + kMinAge}',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Onboarding Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    IndicatorDot(active: false),
                    IndicatorDot(active: false),
                    IndicatorDot(active: true),
                    IndicatorDot(active: false),
                  ],
                ),
                const SizedBox(height: 30),

                // --- Next arrow button (bottom center) ---
                GestureDetector(
                  onTap: _handleNext,
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
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}