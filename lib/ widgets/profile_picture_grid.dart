import 'package:flutter/material.dart';
import 'dart:io';

class ProfilePictureGrid extends StatelessWidget {
  // Accept List<String?> for clean slot control
  final List<String?> photos;
  final Function(int)? onAddOrRemove;

  const ProfilePictureGrid({Key? key, required this.photos, this.onAddOrRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // Always 4 slots for profile UI
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 18, crossAxisSpacing: 18, childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final photo = (index < photos.length) ? photos[index] : null;
        final hasImage = photo != null && photo.isNotEmpty;

        return GestureDetector(
          onTap: onAddOrRemove != null ? () => onAddOrRemove!(index) : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
                style: hasImage ? BorderStyle.none : BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(16),
              image: hasImage
                  ? (photo!.startsWith('/')
                      ? DecorationImage(image: FileImage(File(photo)), fit: BoxFit.cover)
                      : DecorationImage(image: AssetImage(photo), fit: BoxFit.cover))
                  : null,
            ),
            child: !hasImage
                ? const Center(
                    child: Icon(Icons.add_a_photo, color: Colors.white54, size: 36),
                  )
                : null,
          ),
        );
      },
    );
  }
}