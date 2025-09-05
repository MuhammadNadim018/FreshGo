import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/typography.dart';
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

    // // Define scale factors
    // final horizontalPadding = screenWidth * 0.06; // 6% of width
    // //final verticalImageScale = 1.3;
    // final bottomSheetMaxHeight =
    //     screenHeight * (screenHeight < 720 ? 0.72 : 0.56);
    // final bottomSheetMinHeight = screenHeight * 0.47;

    // Text scale factor
    final baseFont = screenWidth / 24; // adjust divisor for size

    return Scaffold(
      body: Column(
        children: [
          // Top image takes 56% of screen height
          Flexible(
            flex: 56,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/onboarding.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Add any image overlays here
              ],
            ),
          ),

          // Bottom sheet takes remaining 44%
          Flexible(
            flex: 44,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 33),
                          Text(
                            'Bring Happiness Local\nFood with Freshgo',
                            style:
                                AppText.interSemiBold(fontSize: baseFont * 1.9),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry. Lorem\nIpsum has been the industry\'s standard',
                            style: AppText.interRegular(
                              color: AppColors.textSecondary,
                              fontSize: baseFont,
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: () => _goHome(context),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.blackButton,
                                    shape: const StadiumBorder(),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text('Skip tour',
                                      style: AppText.sfProSemiBold(
                                          fontSize: baseFont * 0.98)),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FilledButton(
                                  onPressed: () => _goHome(context),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: const StadiumBorder(),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text('Get started',
                                      style: AppText.sfProSemiBold(
                                          fontSize: baseFont * 0.98)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have account? ',
                                style: AppText.interRegular(
                                    color: AppColors.textSecondary,
                                    fontSize: baseFont * 0.85),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: AppText.interSemiBold(
                                        color: AppColors.primary,
                                        fontSize: baseFont * 0.85),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),

                // Responsive pagination pill above sheet
                Positioned(
                  bottom: screenHeight * 0.44, // slightly higher
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth *
                            0.033, // horizontal padding inside pill
                        vertical: screenHeight * 0.0095, // taller pill
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            screenHeight * 0.04), // rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (i) {
                          final isActive = i == 0;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth *
                                    0.0055), // controls gap between dots
                            child: Container(
                              width: screenWidth * 0.035,
                              height: screenHeight * 0.0051, // taller dot
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.01),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
