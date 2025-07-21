import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/event_card.dart';
import '../ widgets/reverb_nav_bar.dart';
import '../models/event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Events list
  static final List<Event> events = [
    Event(
      title: "CAS X’s Tour",
      location: "Gurugram",
      date: "24th January, 2025",
      imagePath: 'assets/cas_event.jpg',
    ),
    Event(
      title: "Lollapalooza",
      location: "Mumbai",
      date: "2026",
      imagePath: 'assets/lolla_event.png',
    ),
    Event(
      title: "Javed Ali Live",
      location: "Hyderabad",
      date: "16th February, 2025",
      imagePath: 'assets/javed_event.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main UI
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/logo_2.png', height: 70),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications, color: Colors.white),
                            onPressed: () => context.go('/notifications'),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () => context.go('/settings'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Banner
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/travis_banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: const [
                        Positioned(
                          bottom: 40,
                          left: 16,
                          child: Text(
                            "Oct 18–19, 2025",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          child: Text(
                            "TRAVIS SCOTT: CIRCUS MAXIMUS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 16,
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 16),
                              SizedBox(width: 5),
                              Text(
                                "Jawaharlal Nehru Stadium, Delhi",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text("Find",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 16),
                  // Option Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _optionBox(
                          context,
                          text: "blind\ndate",
                          icon: Icons.favorite_border,
                          color: Colors.red,
                          onTap: () => context.go('/match-loading'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _optionBox(
                          context,
                          text: "date or\nfriends",
                          icon: Icons.people_alt_outlined,
                          color: Colors.purpleAccent,
                          onTap: () => context.go('/friendly-match-loading'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Suggested For You",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("See all", style: TextStyle(color: Colors.lightBlueAccent)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Event Cards List
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: events
                          .map((event) => EventCard(
                                event: event,
                                onTap: () {
                                  context.go('/event-detail', extra: event);
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Announcements",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("See all", style: TextStyle(color: Colors.lightBlueAccent)),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 0),
    );
  }

  // Option box widget
  Widget _optionBox(BuildContext context,
      {required String text,
      required IconData icon,
      Color? color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(right: 0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color ?? Colors.red, size: 28),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color ?? Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}