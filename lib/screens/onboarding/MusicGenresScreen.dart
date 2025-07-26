import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ widgets/indicator_dot.dart';

class MusicGenresScreen extends StatefulWidget {
  final String? displayName;
  final String? recoveryEmail;
  final List<String>? photos;
  final List<String>? interests;
  final String? pronouns;
  final String? bio;

  const MusicGenresScreen({
    Key? key,
    this.displayName,
    this.recoveryEmail,
    this.photos,
    this.interests,
    this.pronouns,
    this.bio,
  }) : super(key: key);

  @override
  State<MusicGenresScreen> createState() => _MusicGenresScreenState();
}

class _MusicGenresScreenState extends State<MusicGenresScreen> {
  final List<String> genres = [
    'Pop', 'Hip-Hop', 'Jazz',
    'Country', 'Folk', 'Rock',
    'Soul', 'K-pop', 'Bollywood',
    'R&B', 'Techno', 'Indie',
  ];

  final Set<String> selectedGenres = {};

  void _toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  void _navigateNext() {
    context.go('/looking-for', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
      'pronouns': widget.pronouns,
      'bio': widget.bio,
      'genres': selectedGenres.toList(),
    });
  }

  void _navigateBack() {
    context.go('/bio', extra: {
      'displayName': widget.displayName,
      'recoveryEmail': widget.recoveryEmail,
      'photos': widget.photos,
      'interests': widget.interests,
      'pronouns': widget.pronouns,
      'bio': widget.bio,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/genres_bg.png',
              fit: BoxFit.cover,
            ),
          ),
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                      onPressed: _navigateBack,
                      tooltip: 'Back',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Select your Favorite\nMusic Genres",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Pick your favorite genres, connect with\npeople with similar interests",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: genres.map((genre) {
                        final isSelected = selectedGenres.contains(genre);
                        return GestureDetector(
                          onTap: () => _toggleGenre(genre),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.pinkAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: false),
                      IndicatorDot(active: true), // 5th step
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: _navigateNext,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pinkAccent,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}