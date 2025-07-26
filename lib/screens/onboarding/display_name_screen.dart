import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';
import 'media_screen.dart';

/// DisplayNameScreen: Lets user enter display name and navigate forward/back.
/// Receives recoveryEmail as an optional parameter from the previous step.
class DisplayNameScreen extends StatefulWidget {
  final String? recoveryEmail; // (optional) Email from previous onboarding step
  const DisplayNameScreen({super.key, this.recoveryEmail});

  @override
  State<DisplayNameScreen> createState() => _DisplayNameScreenState();
}

class _DisplayNameScreenState extends State<DisplayNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _showError = false; // State for showing input error

  @override
  void dispose() {
    // Dispose controller to prevent memory leaks
    _nameController.dispose();
    super.dispose();
  }

  /// Navigates to the Media screen if display name is valid.
  /// Passes display name and recovery email as router "extra" parameters.
  void _navigateNext() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _showError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your display name")),
      );
      return;
    }
    setState(() => _showError = false);

    // Pass displayName and recoveryEmail (if present) to next route
    context.go('/media', extra: {
      'displayName': name,
      if (widget.recoveryEmail != null) 'recoveryEmail': widget.recoveryEmail,
    });
  }

  /// Navigates back to the Recovery Email screen (step before this)
  void _navigateBack() {
    context.go('/recovery');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents keyboard overflow
      body: Stack(
        children: [
          // === Background Image ===
          SizedBox.expand(
            child: Image.asset(
              'assets/display_name.png',
              fit: BoxFit.cover,
            ),
          ),
          // === Gradient Overlay for readability ===
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
          // === Main Foreground UI ===
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Back Button ===
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 28),
                      onPressed: _navigateBack,
                      tooltip: 'Back',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // === Title ===
                  const Text(
                    "Set a\nDisplay Name",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // === Subtitle / Instructions ===
                  const Text(
                    "Let’s start setting up your profile, please\nenter your name",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // === Name Input Field ===
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.pinkAccent,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                      errorText: _showError ? "Name cannot be empty" : null,
                    ),
                  ),

                  const Spacer(),

                  // === Progress Indicators (Step 2 active) ===
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: true),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // === Next Button ===
                  InkWell(
                    onTap: _navigateNext,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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