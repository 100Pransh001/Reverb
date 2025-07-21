import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../ widgets/indicator_dot.dart';

/// 📏 HeightScreen: User enters their height (cm), with back/next navigation.
/// This screen is part of the onboarding flow.
class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  // Controller to capture user's height input
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    // Cleanup the controller to avoid memory leaks
    _heightController.dispose();
    super.dispose();
  }

  /// Handler for the back arrow – navigates user back to the gender selection screen
  void _handleBack() {
    context.go('/gender');
  }

  /// Handler for the "Next" button – validates height and navigates forward if valid
  void _handleNext() {
    final height = _heightController.text.trim();

    // Check if field is empty or non-numeric
    if (height.isEmpty || int.tryParse(height) == null) {
      _showErrorDialog('Please enter your height in cm.');
      return;
    }

    // Parse height and check for a realistic range
    int value = int.parse(height);
    if (value < 100 || value > 250) {
      _showErrorDialog('Please enter a valid height (100–250 cm).');
      return;
    }

    // Navigate to the AgeScreen, passing height as extra data
    context.go('/age', extra: {'height': value});
  }

  /// Shows a modal error dialog with a custom message
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          'Missing/Invalid Height',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Background image covers the whole screen ---
          SizedBox.expand(
            child: Image.asset(
              'assets/height_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // --- Gradient overlay to ensure foreground text is readable ---
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
          // --- Back arrow at top left corner ---
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                onPressed: _handleBack,
                tooltip: 'Back',
              ),
            ),
          ),
          // --- Main UI content (title, input, progress, next) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Title
                  const Text(
                    "Enter Your Height",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Subtitle
                  const Text(
                    "For a better experience and results,\nplease specify your height",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Height input field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _heightController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allow numbers
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _handleNext(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your height (in cm)',
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Onboarding progress indicator (2nd dot active)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      IndicatorDot(active: false),
                      IndicatorDot(active: true),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Next button (arrow) – triggers validation and navigation
                  AnimatedOpacity(
                    opacity: 1, // Always visible; you can make it conditional if needed
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
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
                  ),
                  const SizedBox(height: 36), // Extra spacing at the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}