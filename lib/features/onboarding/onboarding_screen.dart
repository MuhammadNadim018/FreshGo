import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/typography.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = MediaQuery.sizeOf(context); // preferred helper
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/onboarding.png',
                    fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: size.height * (size.height < 720 ? 0.72 : 0.56),
                    minHeight: size.height * 0.42,
                  ),
                  child: Material(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bring Happiness Local\nFood with Freshgo',
                                  style: T.h1(context)),
                              const SizedBox(height: 12),
                              Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard',
                                style: T.bodyDim(context),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () => _goHome(context),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColors.text,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                      ),
                                      child: const Text('Skip tour',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () => _goHome(context),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                      ),
                                      child: const Text('Get started',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Already have account? ',
                                    style: T.bodyDim(context),
                                    children: [
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Decorative handle
              Positioned(
                bottom: size.height * 0.24,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 36,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
}
