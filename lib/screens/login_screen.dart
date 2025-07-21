import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image Layer
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 🧩 Foreground UI Layer (Safe scrollable form)
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  // 🎯 App Logo
                  Image.asset('assets/logo2.png', height: 120),
                  const SizedBox(height: 10),
                  // 🧾 Login Card Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // 📛 Title
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // 📧 Email Field with Gmail-only validation
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')
                                  .hasMatch(value)) {
                                return 'Enter a valid Gmail address';
                              }
                              return null;
                            },
                            decoration: _inputDecoration("Gmail"),
                          ),
                          const SizedBox(height: 14),

                          // 🔒 Password Field (8–12 character constraint)
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8 || value.length > 12) {
                                return 'Password must be 8-12 characters';
                              }
                              return null;
                            },
                            decoration:
                                _inputDecoration("Password (8-12 characters)"),
                          ),

                          // 🆘 Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Connect to Forgot Password Flow
                              },
                              child: const Text(
                                "Forget password?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // 🚪 Login Button
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO: Integrate with API before navigating
                                context.go('/gender'); // Navigate on success
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFDC2953),
                                    Color(0xFFF78E36)
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ➖ Divider with "or"
                          Row(
                            children: const [
                              Expanded(child: Divider(color: Colors.white70)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("or",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Expanded(child: Divider(color: Colors.white70)),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // 🔐 Social Logins (placeholder only)
                          GestureDetector(
                            onTap: () {
                              // TODO: Google sign-in logic here
                            },
                            child: _socialLogin(
                                "Continue with Google", 'assets/google.png'),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              // TODO: Facebook sign-in logic here
                            },
                            child: _socialLogin(
                                "Continue with Facebook", 'assets/facebook.png'),
                          ),

                          const SizedBox(height: 14),

                          // 🆕 Sign Up Button (UPDATED)
                          TextButton(
                            onPressed: () {
                              context.go('/signup'); // <--- Navigates to signup!
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
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

  /// 🎨 Common Input Field Decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white24,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  /// 🧩 Reusable Widget for Social Login Buttons
  Widget _socialLogin(String text, String iconPath) {
    return Semantics(
      label: text,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 22),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}