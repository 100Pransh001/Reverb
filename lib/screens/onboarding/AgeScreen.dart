import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../ widgets/indicator_dot.dart';

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

  /// Loading state for Firebase operations
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load existing age data when screen initializes
    _loadExistingAge();
  }

  /// Load existing age data from Firebase (optional - for returning users)
  Future<void> _loadExistingAge() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user?.uid == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('user_profile')
          .doc('age')
          .get();

      if (doc.exists && doc.data()?['age'] != null) {
        setState(() {
          selectedAge = doc.data()!['age'];
        });
      }
    } catch (e) {
      // Silently handle errors for loading existing data
      debugPrint('Error loading existing age: $e');
    }
  }

  /// Navigate to previous (Height) screen
  void _handleBack() {
    context.go('/height');
  }

  /// Save age to Firebase and navigate to next screen
  Future<void> _handleNext() async {
    setState(() => isLoading = true);

    try {
      // Get current user's email
      final user = FirebaseAuth.instance.currentUser;
      if (user?.uid == null) {
        throw Exception('User not authenticated');
      }

      // Save age to Firestore at users/{email_id}/user_profile/age
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('user_profile')
          .doc('age')
          .set({
            'age': selectedAge,
            'updated_at': FieldValue.serverTimestamp(),
          });

      // Navigate to next screen after successful save
      if (mounted) {
        context.go('/interestedin', extra: {'age': selectedAge});
      }
    } catch (e) {
      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving age: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Background image ---
          SizedBox.expand(
            child: Image.asset('assets/age_bg.png', fit: BoxFit.cover),
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
                  style: TextStyle(fontSize: 16, color: Colors.white70),
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
                      if (!isLoading) {
                        // Prevent changes during loading
                        setState(() {
                          selectedAge = index + kMinAge;
                        });
                      }
                    },
                    children: List.generate(
                      kMaxAge - kMinAge + 1,
                      (index) => Center(
                        child: Text(
                          '${index + kMinAge}',
                          style: TextStyle(
                            fontSize: 32,
                            color: isLoading ? Colors.white54 : Colors.white,
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
                AnimatedOpacity(
                  opacity: !isLoading ? 1 : 0.5,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: !isLoading ? _handleNext : null,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isLoading ? Colors.pinkAccent : Colors.white24,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
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
