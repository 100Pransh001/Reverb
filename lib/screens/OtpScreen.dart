import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool is18Checked = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _otpController.text.trim().isNotEmpty && is18Checked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
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
                  // OTP Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 38),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.36),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Enter OTP",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 28),
                          // OTP input
                          TextFormField(
                            controller: _otpController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter OTP';
                              }
                              if (value.trim().length < 4) {
                                return 'Enter a valid OTP';
                              }
                              return null;
                            },
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "OTP",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.23),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // 18+ Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: is18Checked,
                                onChanged: (val) {
                                  setState(() {
                                    is18Checked = val ?? false;
                                  });
                                },
                                activeColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Expanded(
                                child: Text(
                                  "I confirm that I am 18 years or older",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          // Continue Button
                          GestureDetector(
                            onTap: _canContinue
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      // On successful OTP
                                      context.go('/create-password'); // update route as needed
                                    }
                                  }
                                : null,
                            child: Opacity(
                              opacity: _canContinue ? 1.0 : 0.5,
                              child: Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFC5756),
                                      Color(0xFFFFA74F),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Continue",
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