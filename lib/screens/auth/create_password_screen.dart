import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _email;

  @override
  void initState() {
    super.initState();
    // Get email from route parameters and current user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      if (extra != null && extra['email'] != null) {
        _email = extra['email'] as String;
      } else if (FirebaseAuth.instance.currentUser != null) {
        _email = FirebaseAuth.instance.currentUser!.email;
      }
    });
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _passController.text.trim().isNotEmpty &&
      _confirmPassController.text.trim().isNotEmpty &&
      _passController.text.length >= 8 &&
      _passController.text == _confirmPassController.text &&
      !_isLoading;

  // Password strength checker
  bool _hasUppercase(String password) => password.contains(RegExp(r'[A-Z]'));
  bool _hasLowercase(String password) => password.contains(RegExp(r'[a-z]'));
  bool _hasDigits(String password) => password.contains(RegExp(r'[0-9]'));
  bool _hasSpecialCharacters(String password) =>
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '';

    int score = 0;
    if (password.length >= 8) score++;
    if (_hasUppercase(password)) score++;
    if (_hasLowercase(password)) score++;
    if (_hasDigits(password)) score++;
    if (_hasSpecialCharacters(password)) score++;

    switch (score) {
      case 0:
      case 1:
      case 2:
        return 'Weak';
      case 3:
      case 4:
        return 'Medium';
      case 5:
        return 'Strong';
      default:
        return '';
    }
  }

  Color _getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'Weak':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Strong':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if user is authenticated and email is verified
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      _showErrorMessage(
        'User not found. Please start the signup process again.',
      );
      return;
    }

    if (!currentUser.emailVerified) {
      _showErrorMessage('Please verify your email first.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newPassword = _passController.text.trim();

      // Update the user's password
      await currentUser.updatePassword(newPassword);

      // Reload user to get updated information
      await currentUser.reload();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login screen
        context.go('/');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please log in again to update your password.';
          // Sign out user and redirect to login
          await FirebaseAuth.instance.signOut();
          if (mounted) {
            context.go('/login');
          }
          break;
        default:
          errorMessage = 'Error updating password: ${e.message}';
      }
      _showErrorMessage(errorMessage);
    } catch (e) {
      _showErrorMessage('Error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordStrength = _getPasswordStrength(_passController.text);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 38),
                  // Logo
                  Image.asset('assets/logo2.png', height: 98),
                  const SizedBox(height: 8),
                  // Card
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 38,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.36),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Create Password",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Email display
                          if (_email != null)
                            Text(
                              "Creating account for $_email",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 28),
                          // Password input
                          TextFormField(
                            controller: _passController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Colors.white),
                            enabled: !_isLoading,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              if (!_hasUppercase(value)) {
                                return 'Password must contain at least one uppercase letter';
                              }
                              if (!_hasLowercase(value)) {
                                return 'Password must contain at least one lowercase letter';
                              }
                              if (!_hasDigits(value)) {
                                return 'Password must contain at least one number';
                              }
                              return null;
                            },
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.23),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  );
                                },
                              ),
                            ),
                          ),
                          // Password strength indicator
                          if (_passController.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Password Strength: ',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  passwordStrength,
                                  style: TextStyle(
                                    color: _getPasswordStrengthColor(
                                      passwordStrength,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                          // Confirm Password input
                          TextFormField(
                            controller: _confirmPassController,
                            obscureText: _obscureConfirmPassword,
                            style: const TextStyle(color: Colors.white),
                            enabled: !_isLoading,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.23),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscureConfirmPassword =
                                        !_obscureConfirmPassword,
                                  );
                                },
                              ),
                            ),
                          ),
                          // Password match indicator
                          if (_confirmPassController.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  _passController.text ==
                                          _confirmPassController.text
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  size: 16,
                                  color:
                                      _passController.text ==
                                          _confirmPassController.text
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _passController.text ==
                                          _confirmPassController.text
                                      ? 'Passwords match'
                                      : 'Passwords do not match',
                                  style: TextStyle(
                                    color:
                                        _passController.text ==
                                            _confirmPassController.text
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 26),
                          // Continue Button
                          GestureDetector(
                            onTap: _canContinue ? _createAccount : null,
                            child: Opacity(
                              opacity: _canContinue ? 1.0 : 0.5,
                              child: Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                    colors: _isLoading
                                        ? [Colors.grey, Colors.grey]
                                        : [
                                            const Color(0xFFFC5756),
                                            const Color(0xFFFFA74F),
                                          ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        )
                                      : const Text(
                                          "Create Account",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                        ),
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
            ),
          ),
        ],
      ),
    );
  }
}
