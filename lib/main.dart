import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FreshGoApp());
}

class FreshGoApp extends StatelessWidget {
  const FreshGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
