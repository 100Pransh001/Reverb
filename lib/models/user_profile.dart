class UserProfile {
  final String name;
  final int age;
  final String pronouns;
  final List<String> photos; // asset paths or URLs
  final String bio;

  UserProfile({
    required this.name,
    required this.age,
    required this.pronouns,
    required this.photos,
    required this.bio,
  });
}