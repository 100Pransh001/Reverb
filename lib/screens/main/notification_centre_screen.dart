import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Single Notification Card Widget
class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notif;
  final VoidCallback onDelete;

  const NotificationCard({
    Key? key,
    required this.notif,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onDelete, // For mobile, use long-press to delete
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: notif['bg'] ?? [Colors.white, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar or Icon
            notif['avatar'] != null
                ? CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(notif['avatar']),
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(notif['icon'], color: notif['iconColor'], size: 28),
                  ),
            const SizedBox(width: 12),
            // Notification details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            if (notif['avatar'] != null)
                              TextSpan(
                                text: "Name",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            if (notif['avatar'] != null)
                              const TextSpan(text: " "),
                            TextSpan(
                              text: notif['title'].replaceFirst("Name ", ""),
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (notif['avatar'] != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Icon(notif['icon'], color: notif['iconColor'], size: 18),
                        ),
                    ],
                  ),
                  Text(
                    notif['subtitle'],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // (Optional) Delete Icon for feedback, visible on long press
            // IconButton(
            //   icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
            //   onPressed: onDelete,
            // ),
          ],
        ),
      ),
    );
  }
}

// Main Notification Centre Screen
class NotificationCentreScreen extends StatefulWidget {
  const NotificationCentreScreen({Key? key}) : super(key: key);

  @override
  State<NotificationCentreScreen> createState() => _NotificationCentreScreenState();
}

class _NotificationCentreScreenState extends State<NotificationCentreScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'avatar': 'assets/my_profile.jpg',
      'icon': Icons.group,
      'iconColor': Colors.black,
      'title': 'Name matched with you!',
      'subtitle': 'Continue to chat',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFF6E7)],
    },
    {
      'avatar': 'assets/my_profile.jpg',
      'icon': Icons.favorite,
      'iconColor': Colors.red,
      'title': 'Name matched with you!',
      'subtitle': 'Continue to chat',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFF6E7)],
    },
    {
      'avatar': 'assets/my_profile.jpg',
      'icon': Icons.favorite,
      'iconColor': Colors.red,
      'title': 'Name sent a message',
      'subtitle': 'Text preview',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFF6E7)],
    },
    {
      'avatar': 'assets/my_profile.jpg',
      'icon': Icons.group,
      'iconColor': Colors.black,
      'title': 'Name sent a message',
      'subtitle': 'Text preview',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFF6E7)],
    },
    {
      'avatar': null,
      'icon': Icons.group,
      'iconColor': Colors.black,
      'title': '54 People liked you!',
      'subtitle': 'Match now',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFE8EC)],
    },
    {
      'avatar': null,
      'icon': Icons.favorite,
      'iconColor': Colors.red,
      'title': '54 People liked you!',
      'subtitle': 'Match now',
      'bg': [Color(0xFFFDF4FF), Color(0xFFFFE8EC)],
    },
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
    // Optional: You can add a Snackbar for feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background (matches other screens)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7EAFB), Color(0xFFEBCFF7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Notification Centre",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF580A46),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.home_outlined, color: Color(0xFF580A46), size: 32),
                        onPressed: () => context.go('/home'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Notifications List
                  Expanded(
                    child: notifications.isEmpty
                        ? const Center(
                            child: Text(
                              "No notifications",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          )
                        : ListView.separated(
                            itemCount: notifications.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 18),
                            itemBuilder: (context, i) {
                              return NotificationCard(
                                notif: notifications[i],
                                onDelete: () => _deleteNotification(i),
                              );
                            },
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