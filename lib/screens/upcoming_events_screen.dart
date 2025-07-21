import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/big_event_card.dart';
import '../ widgets/reverb_nav_bar.dart';
import '../models/event.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  // List of events
  static final List<Event> events = [
    Event(
      title: "TRAVIS SCOTT: CIRCUS MAXIMUS",
      date: "Oct 18–19, 2025",
      location: "Jawaharlal Nehru Stadium, Delhi",
      imagePath: 'assets/travis_event.jpg',
    ),
    Event(
      title: "ARMAAN MALIK",
      date: "Sept 13, 2025",
      location: "Phoenix Market City, Bangalore",
      imagePath: 'assets/armaan_event.jpg',
    ),
    Event(
      title: "KUMAR SANU",
      date: "July 26, 2025",
      location: "Venue: TBA",
      imagePath: 'assets/kumar_event.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // BG
          SizedBox.expand(
            child: Image.asset(
              'assets/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Events",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...events.map(
                    (event) => BigEventCard(
                      event: event,
                      onPressed: () {
                        context.go('/event-detail', extra: event);
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 1),
    );
  }
}