import 'package:flutter/material.dart';

class IndicatorDot extends StatelessWidget {
  final bool active;
  const IndicatorDot({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 20,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.pinkAccent : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}