import 'package:flutter/material.dart';
import 'router.dart'; // Import the centralized GoRouter configuration

// The main entry point of the app
void main() {
  runApp(ReverbApp());
}

// The root widget of the Reverb app
class ReverbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MaterialApp.router enables advanced navigation with go_router
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Reverb',                   // App name
      theme: ThemeData(
        primarySwatch: Colors.purple,    // Primary theme color
      ),
      // routerConfig links the app to your go_router setup in router.dart
      routerConfig: router,
    );
  }
}