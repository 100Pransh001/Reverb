import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'dart:io';

class ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final double imageSize;

  const ProfileCard({Key? key, required this.profile, this.imageSize = 340}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if a valid photo exists
    bool hasPhoto = profile.photos.isNotEmpty && profile.photos[0].trim().isNotEmpty;

    ImageProvider? imageProvider;
    if (hasPhoto) {
      final path = profile.photos[0];
      if (path.startsWith('/')) {
        // Local file path
        imageProvider = FileImage(File(path));
      } else {
        // Asset path
        imageProvider = AssetImage(path);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Only show image if photo exists
        if (hasPhoto && imageProvider != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image(
              image: imageProvider,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),
        if (hasPhoto) const SizedBox(height: 34),
        // Name, Age, Pronouns
        Row(
          children: [
            Text(
              '${profile.name}, ${profile.age} ',
              style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28,
              ),
            ),
            Text(
              profile.pronouns,
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bio
        Text(
          profile.bio,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ],
    );
  }
}