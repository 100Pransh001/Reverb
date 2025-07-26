import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double distance = 70;
  RangeValues ageRange = const RangeValues(22, 30);
  String gender = 'Female';
  Set<String> selectedInterests = {'Female', 'Gym', 'Swimming'};
  bool profileVisible = true;
  bool eventNotifications = true;
  bool messageNotifications = true;
  bool tripNotifications = false;

  final List<String> genders = [
    'Male', 'Female', 'Open to Everyone'
  ];

  final List<String> interests = [
    'Movies', 'Gym', 'Video Games',
    'Cooking', 'Swimming', 'Crocheting',
    'Photography', 'Astrology', 'Journaling',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xFF580A46),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.home_outlined, color: Color(0xFF580A46), size: 32),
                        onPressed: () {
                          context.go('/home'); // <-- navigate to HomeScreen
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Preferences",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF580A46),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Distance Filter
                  const Text(
                    "Distance",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  Slider(
                    value: distance,
                    min: 5,
                    max: 100,
                    divisions: 19,
                    activeColor: const Color(0xFF580A46),
                    inactiveColor: Colors.black12,
                    onChanged: (val) => setState(() => distance = val),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('5 Km', style: TextStyle(color: Colors.black54)),
                      Text('${distance.round()} Km', style: const TextStyle(color: Color(0xFF580A46), fontWeight: FontWeight.bold)),
                      const Text('100 Km+', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Age Range
                  const Text(
                    "Age",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  RangeSlider(
                    values: ageRange,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    labels: RangeLabels("${ageRange.start.round()}", "${ageRange.end.round()}"),
                    activeColor: const Color(0xFF580A46),
                    inactiveColor: Colors.black12,
                    onChanged: (val) => setState(() => ageRange = val),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${ageRange.start.round()}', style: const TextStyle(color: Colors.black54)),
                      Text('${ageRange.end.round()}', style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Gender Selection (Wrap to avoid overflow)
                  const Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: genders.map((g) {
                      final isSelected = gender == g;
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isSelected ? const Color(0xFFF7EAFB) : null,
                          side: BorderSide(
                            color: const Color(0xFF580A46),
                            width: isSelected ? 2 : 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () => setState(() => gender = g),
                        child: Text(
                          g,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF580A46) : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Interests
                  const Text(
                    "Interests",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: interests.map((interest) {
                      final selected = selectedInterests.contains(interest);
                      return ChoiceChip(
                        label: Text(interest),
                        selected: selected,
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedInterests.add(interest);
                            } else {
                              selectedInterests.remove(interest);
                            }
                          });
                        },
                        selectedColor: const Color(0xFFF7EAFB),
                        labelStyle: TextStyle(
                          color: selected ? const Color(0xFF580A46) : Colors.black87,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF580A46),
                          width: 1.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    }).toList(),
                  ),

                  // Privacy and Safety
                  const SizedBox(height: 30),
                  const Text(
                    "Privacy and Safety",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: Color(0xFF580A46)),
                  ),
                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Profile Visibility",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: profileVisible,
                        activeColor: const Color(0xFF580A46),
                        onChanged: (val) => setState(() => profileVisible = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  const SizedBox(height: 10),

                  _settingsSwitch("Event Notifications", eventNotifications, (val) => setState(() => eventNotifications = val)),
                  _settingsSwitch("Message Notifications", messageNotifications, (val) => setState(() => messageNotifications = val)),
                  _settingsSwitch("Trip Notifications", tripNotifications, (val) => setState(() => tripNotifications = val)),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xFF580A46),
          onChanged: onChanged,
        ),
      ],
    );
  }
}