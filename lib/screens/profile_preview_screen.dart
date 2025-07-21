import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/profile_card.dart';
import '../ widgets/reverb_nav_bar.dart';
import '../models/user_profile.dart';

class ProfilePreviewScreen extends StatelessWidget {
  final UserProfile profile;
  const ProfilePreviewScreen({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/profile_bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                // Tabs (Edit / Preview)
                Row(
                  children: [
                    _TabButton(
                      label: "Edit",
                      selected: false,
                      onTap: () => context.go('/profile/edit', extra: profile),
                    ),
                    _TabButton(
                      label: "Preview",
                      selected: true,
                      onTap: () {}, // Already on preview
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // ProfileCard
                ProfileCard(profile: profile, imageSize: 360),
                const SizedBox(height: 32),
                // Optionally show more info/widgets here (Interests, Genres, etc)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 4),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({required this.label, required this.selected, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: selected ? Colors.white.withOpacity(0.13) : Colors.transparent,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}