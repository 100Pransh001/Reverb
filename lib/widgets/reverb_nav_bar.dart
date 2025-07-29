import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReverbNavBar extends StatelessWidget {
  final int selectedIndex;
  const ReverbNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return; // Avoid duplicate navigation

    if (!context.mounted) return;

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/events');
        break;
      case 2:
        context.go('/likes');
        break;
      case 3:
        context.go('/chats'); // <-- This will now open ChatsScreen
        break;
      case 4:
        context.go('/profile'); // Add this route in router.dart if you have profile screen!
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF580A46),
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), label: 'Likes'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}