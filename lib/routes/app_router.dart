// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/detail/detail_screen.dart';
import '../../models/place.dart';

class AppRouter {
  static Route<dynamic> onGenerate(RouteSettings s) {
    switch (s.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/detail':
        final place = s.arguments as Place; // expect a Place
        return MaterialPageRoute(builder: (_) => DetailScreen(place: place));
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }
}
