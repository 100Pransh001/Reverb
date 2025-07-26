import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reverb/screens/FriendlyMatchScreen.dart';
import 'package:reverb/screens/MusicGenresScreen.dart';

// Import screens (no duplicates)
import 'screens/login_screen.dart';
import 'screens/genderscreen.dart';
import 'screens/heightscreen.dart';
import 'screens/agescreen.dart';
import 'screens/interestedinscreen.dart';
import 'screens/recovery_email_screen.dart';
import 'screens/display_name_screen.dart';
import 'screens/media_screen.dart';
import 'screens/interests_screen.dart';
import 'screens/pronouns_screen.dart';
import 'screens/bio_screen.dart';
import 'screens/looking_for_screen.dart';
import 'screens/home_screen.dart';
import 'screens/upcoming_events_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/swipe_profiles_screen.dart' hide UserProfile;
import 'screens/match_screen.dart';
import 'screens/friendly_match_screen.dart';
import 'screens/ChatsScreen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/profile_preview_screen.dart';
import 'screens/match_loading_screen.dart';
import 'screens/found_match_screen.dart';
import 'screens/settings_screen.dart'; // Make sure the path is correct!
import 'screens/notification_centre_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/create_password_screen.dart';

import 'models/event.dart';
import 'models/user_profile.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const LoginScreen()),
    ),
    GoRoute(
      path: '/gender',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const GenderScreen()),
    ),
    GoRoute(
      path: '/height',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const HeightScreen()),
    ),
    GoRoute(
      path: '/age',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const AgeScreen()),
    ),
    GoRoute(
      path: '/interestedin',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const InterestedInScreen()),
    ),
    GoRoute(
      path: '/recovery',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const RecoveryEmailScreen()),
    ),
    GoRoute(
      path: '/display-name',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          DisplayNameScreen(recoveryEmail: extra['recoveryEmail'] ?? ""),
        );
      },
    ),
    GoRoute(
      path: '/media',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          MediaScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
          ),
        );
      },
    ),
    GoRoute(
      path: '/interests',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          InterestsScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
            photos: extra['photos'] is List<String>
                ? extra['photos']
                : <String>[],
          ),
        );
      },
    ),
    GoRoute(
      path: '/pronouns',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          PronounsScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
            photos: extra['photos'] is List<String>
                ? extra['photos']
                : <String>[],
            interests: extra['interests'] is List<String>
                ? extra['interests']
                : <String>[],
          ),
        );
      },
    ),
    GoRoute(
      path: '/bio',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          BioScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
            photos: extra['photos'] is List<String>
                ? extra['photos']
                : <String>[],
            interests: extra['interests'] is List<String>
                ? extra['interests']
                : <String>[],
            pronouns: extra['pronouns'] ?? "",
          ),
        );
      },
    ),
    GoRoute(
      path: '/genres',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          MusicGenresScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
            photos: extra['photos'] is List<String>
                ? extra['photos']
                : <String>[],
            interests: extra['interests'] is List<String>
                ? extra['interests']
                : <String>[],
            pronouns: extra['pronouns'] ?? "",
            bio: extra['bio'] ?? "",
          ),
        );
      },
    ),
    GoRoute(
      path: '/looking-for',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return _buildTransitionPage(
          context,
          state,
          LookingForScreen(
            displayName: extra['displayName'] ?? "",
            recoveryEmail: extra['recoveryEmail'] ?? "",
            photos: extra['photos'] is List<String>
                ? extra['photos']
                : <String>[],
            interests: extra['interests'] is List<String>
                ? extra['interests']
                : <String>[],
            pronouns: extra['pronouns'] ?? "",
            bio: extra['bio'] ?? "",
            genres: extra['genres'] is List<String>
                ? extra['genres']
                : <String>[],
          ),
        );
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const HomeScreen()),
    ),
    GoRoute(
      path: '/event-detail',
      pageBuilder: (context, state) {
        final event = state.extra as Event;
        return _buildTransitionPage(
          context,
          state,
          EventDetailScreen(event: event),
        );
      },
    ),
    GoRoute(
      path: '/events',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const UpcomingEventsScreen()),
    ),
    GoRoute(
      path: '/likes',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, SwipeProfilesScreen()),
    ),
    GoRoute(
      path: '/match',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MaterialPage(
          child: MatchScreen(
            myImagePath: extra['myImagePath'],
            otherImagePath: extra['otherImagePath'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/friendly-match',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return MaterialPage(
          child: FriendlyMatchScreen(
            myImagePath: extra['myImagePath'],
            otherImagePath: extra['otherImagePath'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/chats',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const ChatsScreen()),
    ),

    // --- PROFILE TAB ---
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        final UserProfile profile =
            state.extra as UserProfile? ??
            UserProfile(
              name: "A",
              age: 19,
              pronouns: "she/her",
              photos: ['assets/my_profile.jpg'],
              bio:
                  "Low tolerance for BS, high standards for playlists. If you’re emotionally fluent and slightly unhinged (in a fun way), we’ll get along.",
            );
        return _buildTransitionPage(
          context,
          state,
          ProfileEditScreen(profile: profile),
        );
      },
    ),
    GoRoute(
      path: '/profile/preview',
      pageBuilder: (context, state) {
        final UserProfile profile = state.extra as UserProfile;
        return _buildTransitionPage(
          context,
          state,
          ProfilePreviewScreen(profile: profile),
        );
      },
    ),
    GoRoute(
      path: '/profile/edit',
      pageBuilder: (context, state) {
        final UserProfile profile =
            state.extra as UserProfile? ??
            UserProfile(
              name: "A",
              age: 19,
              pronouns: "she/her",
              photos: ['assets/my_profile.jpg'],
              bio:
                  "Low tolerance for BS, high standards for playlists. If you’re emotionally fluent and slightly unhinged (in a fun way), we’ll get along.",
            );
        return _buildTransitionPage(
          context,
          state,
          ProfileEditScreen(profile: profile),
        );
      },
    ),
    // --- MATCH FLOW SCREENS with custom transition ---
    GoRoute(
      path: '/match-loading',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const MatchLoadingScreen()),
    ),
    GoRoute(
      path: '/friendly-match-loading',
      pageBuilder: (context, state) => _buildTransitionPage(
        context,
        state,
        const FriendlyMatchLoadingScreen(),
      ),
    ),
    GoRoute(
      path: '/found-match',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const FoundMatchScreen()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const SettingsScreen()),
    ),
    GoRoute(
      path: '/notifications',
      pageBuilder: (context, state) => _buildTransitionPage(
        context,
        state,
        const NotificationCentreScreen(),
      ),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const SignupScreen()),
    ),

    GoRoute(
      path: '/create-password',
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, const CreatePasswordScreen()),
    ),
  ],
);

CustomTransitionPage _buildTransitionPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetTween = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(
        position: animation.drive(offsetTween),
        child: child,
      );
    },
  );
}
