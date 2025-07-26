import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../ widgets/profile_picture_grid.dart';
import '../../ widgets/reverb_nav_bar.dart';
import '../../models/user_profile.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserProfile profile;
  const ProfileEditScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late List<String?> photos;
  late TextEditingController nameController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Always use exactly 4 slots for UI consistency.
    photos = List<String?>.filled(4, null);
    for (int i = 0; i < widget.profile.photos.length && i < 4; i++) {
      photos[i] = widget.profile.photos[i];
    }
    nameController = TextEditingController(text: widget.profile.name);
  }

  Future<void> _onAddOrRemove(int index) async {
    if (photos[index] != null && photos[index]!.isNotEmpty) {
      // Remove photo
      setState(() => photos[index] = null);
    } else {
      // Pick new photo from gallery
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          photos[index] = picked.path; // File path (can be sent to backend)
        });
        // TODO: After upload to backend, replace photos[index] with URL
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/profile_bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(22),
              children: [
                // Tabs
                Row(
                  children: [
                    _TabButton(label: "Edit", selected: true, onTap: () {}),
                    _TabButton(
                      label: "Preview",
                      selected: false,
                      onTap: () {
                        // Pass only valid (non-null) photos for preview.
                        context.go('/profile/preview', extra: UserProfile(
                          name: nameController.text,
                          age: widget.profile.age,
                          pronouns: widget.profile.pronouns,
                          photos: photos.whereType<String>().where((e) => e.isNotEmpty).toList(),
                          bio: widget.profile.bio,
                        ));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Avatar & Name
                Row(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.white38,
                      backgroundImage: (photos.isNotEmpty && photos[0] != null && photos[0]!.isNotEmpty)
                          ? (photos[0]!.startsWith('/')
                              ? FileImage(File(photos[0]!)) as ImageProvider
                              : AssetImage(photos[0]!))
                          : null,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white38),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  "Add/Remove pictures",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ProfilePictureGrid(photos: photos, onAddOrRemove: _onAddOrRemove),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ReverbNavBar(selectedIndex: 4),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: selected ? Colors.white.withOpacity(0.13) : Colors.transparent,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}