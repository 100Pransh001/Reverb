import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

/// Screen for optionally collecting a recovery email from the user.
/// - No back arrow; only system back gesture is handled.
/// - Allows proceeding with or without a valid email.
class RecoveryEmailScreen extends StatefulWidget {
  const RecoveryEmailScreen({super.key});

  @override
  State<RecoveryEmailScreen> createState() => _RecoveryEmailScreenState();
}

class _RecoveryEmailScreenState extends State<RecoveryEmailScreen> {
  // Controller for the recovery email input field
  final TextEditingController _emailController = TextEditingController();

  // Whether to show an error for invalid email
  bool _showError = false;

  @override
  void dispose() {
    // Free up resources held by the controller
    _emailController.dispose();
    super.dispose();
  }

  /// Simple regex-based email validation
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  /// Handler for forward button:
  /// - Allows navigation if email is empty.
  /// - Validates and shows error if email is non-empty but invalid.
  void _navigateNext() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty && !_isValidEmail(email)) {
      setState(() => _showError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid email or leave it empty")),
      );
      return;
    }
    setState(() => _showError = false);
    context.go(
      '/display-name',
      extra: {'recoveryEmail': email}, // Passing entered email (can be empty)
    );
  }

  /// Handles system back (hardware or swipe)
  /// - Navigates to the 'interestedin' screen
  void _navigateBack() {
    context.go('/interestedin');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Override system back navigation
      onWillPop: () async {
        _navigateBack();
        return false; // Prevent default pop
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Background image layer
            SizedBox.expand(
              child: Image.asset(
                'assets/interested_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay for better contrast
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Main content starts here
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer for top
                    const SizedBox(height: 60),
                    // Title text
                    const Text(
                      "Add a\nRecovery Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Subheading explaining optionality
                    const Text(
                      "To keep your account safe, add a\nsecondary email (optional)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Decorative label for section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Center(
                        child: Text(
                          "Recovery Email",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email input field (optional)
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.pinkAccent,
                      decoration: InputDecoration(
                        hintText: 'Enter your email here (optional)',
                        hintStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.pinkAccent),
                        ),
                        errorText: _showError
                            ? "Enter a valid email or leave it empty"
                            : null,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Progress indicators for multi-step onboarding
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IndicatorDot(active: true),
                        IndicatorDot(active: false),
                        IndicatorDot(active: false),
                        IndicatorDot(active: false),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Next button (always enabled)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: _navigateNext,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
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
                    const SizedBox(height: 22),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}