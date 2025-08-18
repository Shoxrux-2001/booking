import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/core/services/auth_service.dart';
import 'package:restaurant/features/history/history.dart';
import 'package:restaurant/features/home/book_screen.dart';
import 'package:restaurant/features/home/home_screen.dart';
import 'package:restaurant/features/home/map_screen.dart';
import 'package:restaurant/features/onboarding/presentation/routes/onboarding_router.dart';
import 'package:restaurant/features/auth/presentation/screens/success_screen.dart';

import 'package:restaurant/features/profile/profile.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final isOnboarded = await AuthService.isOnboarded();
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    if (!isOnboarded && state.matchedLocation != '/onboarding') {
      return '/onboarding';
    }
    if (isAuthenticated && state.matchedLocation == '/success') {
      return '/home';
    }
    // Agar onboarding o'tkazilgan va authentifikatsiya yo'q bo'lsa, login yoki home ga yo'naltirish
    if (isOnboarded && !isAuthenticated) {
      return '/success'; // Kirish ekrani
    }
    return null; // Agar hamma shart bajarilgan bo'lsa, joriy yo'nalishda qolish
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
    ...onboardingRoutes,
    GoRoute(
      path: '/success',
      builder: (context, state) => const SuccessScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/history', builder: (context, state) => const History()),
    GoRoute(path: '/profile', builder: (context, state) => const Profile()),
    GoRoute(
      path: '/map',
      builder: (context, state) =>
          MapScreen(extra: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(path: '/book', builder: (context, state) => const BookScreen()),
  ],
);
