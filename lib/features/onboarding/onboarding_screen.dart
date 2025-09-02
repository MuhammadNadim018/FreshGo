import 'package:flutter/material.dart';
import 'package:freshgo/core/theme/typography.dart';
import '../../core/theme/app_colors.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get full screen dimensions
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    // Define scale factors
    final horizontalPadding = screenWidth * 0.06; // 6% of width
    final verticalImageScale = 1.3;
    final bottomSheetMaxHeight =
        screenHeight * (screenHeight < 720 ? 0.72 : 0.56);
    final bottomSheetMinHeight = screenHeight * 0.42;
    // Text scale factor
    final baseFont = screenWidth / 24; // adjust divisor for size

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Responsive full‐screen background
              Positioned.fill(
                child: ClipRect(
                  child: Transform.scale(
                    scale: verticalImageScale,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/onboarding.png',
                      fit: BoxFit.fitWidth,
                      width: screenWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // Responsive bottom sheet with pagination pill
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: bottomSheetMaxHeight,
                    minHeight: bottomSheetMinHeight,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // The white sheet
                      Material(
                        color: Colors.white,
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              screenHeight * 0.04,
                              horizontalPadding,
                              screenHeight * 0.03,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    'Bring Happiness Local\nFood with Freshgo',
                                    style: AppText.interSemiBold(
                                        fontSize: baseFont * 1.85),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),

                                  // Description
                                  Text(
                                    'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry. Lorem\nIpsum has been the industry\'s standard',
                                    style: AppText.interRegular(
                                      color: Colors.grey.shade800,
                                      fontSize: baseFont * 1.0,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.025),

                                  // Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: () => _goHome(context),
                                          style: FilledButton.styleFrom(
                                            backgroundColor: AppColors.text,
                                            shape: StadiumBorder(),
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.018,
                                            ),
                                          ),
                                          child: Text(
                                            'Skip tour',
                                            style: AppText.sfProSemiBold(
                                              fontSize: baseFont * 0.9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.025),
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: () => _goHome(context),
                                          style: FilledButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            shape: StadiumBorder(),
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.018,
                                            ),
                                          ),
                                          child: Text(
                                            'Get started',
                                            style: AppText.sfProSemiBold(
                                              fontSize: baseFont * 0.9,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.05),

                                  // Login text
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Already have account? ',
                                        style: AppText.interRegular(
                                          color: Colors.grey.shade800,
                                          fontSize: baseFont * 0.8,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Login',
                                            style: AppText.interRegular(
                                              color: AppColors.primary,
                                              fontSize: baseFont * 0.8,
                                            ),
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

                      // Responsive pagination pill positioned relative to sheet
                      Positioned(
                        top: -(bottomSheetMinHeight *
                            0.13), // 8% of sheet height above top
                        left: (screenWidth - screenWidth * 0.25) /
                            2, // center pill at 30% width
                        child: Container(
                          width:
                              screenWidth * 0.25, // pill = 30% of screen width
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.033, // 4% of width
                            vertical: screenHeight * 0.012, // 1.2% of height
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (i) {
                              final isActive = i == 0;
                              return Container(
                                width: screenWidth * 0.045, // ~dot width
                                height: screenHeight * 0.005, // ~dot height
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.primary
                                      : Colors.grey.shade300,
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.02),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
