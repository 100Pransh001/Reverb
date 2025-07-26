import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchLoadingScreen extends StatefulWidget {
  const MatchLoadingScreen({Key? key}) : super(key: key);

  @override
  State<MatchLoadingScreen> createState() => _MatchLoadingScreenState();
}

class _MatchLoadingScreenState extends State<MatchLoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to /found-match after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/found-match');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient background image
          Positioned.fill(
            child: Image.asset(
              'assets/bg_gradient_match.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AnimatedDots(),
                const SizedBox(height: 32),
                const Text(
                  "Finding a Match",
                  style: TextStyle(
                    color: Color(0xFF580A46),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots({Key? key}) : super(key: key);

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 1, end: 1.7).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6, curve: Curves.easeInOut)),
    );
    _animation2 = Tween<double>(begin: 1, end: 1.7).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.8, curve: Curves.easeInOut)),
    );
    _animation3 = Tween<double>(begin: 1, end: 1.7).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _animation1,
          child: const Dot(color: Colors.cyanAccent),
        ),
        const SizedBox(width: 8),
        ScaleTransition(
          scale: _animation2,
          child: const Dot(color: Colors.cyanAccent),
        ),
        const SizedBox(width: 8),
        ScaleTransition(
          scale: _animation3,
          child: const Dot(color: Colors.cyanAccent),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  const Dot({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}