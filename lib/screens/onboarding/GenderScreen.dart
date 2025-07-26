import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

/// 👤 GenderScreen: Lets the user select their gender as part of onboarding.
/// Keeps next button and progress indicator always at the bottom, with
/// a beautiful background and scrollable content for any device.
class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  /// Stores which gender is selected (Male, Female, Others, or null if none)
  String? selectedGender;

  /// Updates selectedGender state when user taps a gender option
  void _handleGenderTap(String gender) {
    setState(() => selectedGender = gender);
  }

  /// Navigates to height input screen, only allowed if a gender is selected
  void _goToNextScreen() {
    context.go('/height');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack so bottom bar stays fixed while content scrolls
      body: Stack(
        children: [
          // 🖼️ Fullscreen background image
          const SizedBox.expand(
            child: Image(
              image: AssetImage('assets/gender.png'),
              fit: BoxFit.cover,
            ),
          ),
          // 🌑 Semi-transparent gradient overlay for text readability
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
          // 📦 Main scrollable onboarding content (title, subtitle, options)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  // 🏷️ Title
                  const Text(
                    'Choose Your Gender',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // 📋 Subtitle
                  const Text(
                    'To give you better experience and result\nwe need to know your gender',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // 👦 Male option
                  GenderButton(
                    label: 'Male',
                    icon: Icons.male,
                    selected: selectedGender == 'Male',
                    onTap: () => _handleGenderTap('Male'),
                  ),
                  // 👧 Female option
                  GenderButton(
                    label: 'Female',
                    icon: Icons.female,
                    selected: selectedGender == 'Female',
                    onTap: () => _handleGenderTap('Female'),
                  ),
                  // 🏳️‍⚧️ Others option
                  GenderButton(
                    label: 'Others',
                    icon: Icons.transgender,
                    selected: selectedGender == 'Others',
                    onTap: () => _handleGenderTap('Others'),
                  ),
                  // Spacer so content does not hide behind fixed bottom bar
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
          // ⬇️ Bottom bar with progress dots and next arrow (fixed position)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔘 Progress indicators (first dot active for Gender)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      IndicatorDot(active: true),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // 👉 Next arrow button (disabled unless something is selected)
                  AnimatedOpacity(
                    opacity: selectedGender != null ? 1 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: selectedGender != null ? _goToNextScreen : null,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedGender != null
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 💡 Reusable widget for displaying a gender option with icon and highlight.
class GenderButton extends StatelessWidget {
  final String label;        // Gender name (Male/Female/Others)
  final IconData icon;       // Icon to show
  final bool selected;       // Whether this button is currently selected
  final VoidCallback onTap;  // Tap handler

  const GenderButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.pinkAccent.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.pinkAccent : Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            color: selected
                ? Colors.pinkAccent.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}