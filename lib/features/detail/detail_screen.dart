// lib/features/detail/detail_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/place.dart';
import '../../core/theme/typography.dart';

class DetailScreen extends StatelessWidget {
  final Place place;
  const DetailScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;

    // Responsiveness
    final hPad = (w * 0.06); //.clamp(16.0, 28.0);
    final baseFont = (w / 24); //.clamp(12.0, 20.0);
    final overlayHeight = h * 0.045;

    return Scaffold(
      body: Stack(
        children: [
          // background map
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // back button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(w * 0.03),
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blackButton,
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03,
                    vertical: h * 0.008,
                  ),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: Text(
                  'Back',
                  style: AppText.interMedium(
                    color: Colors.white,
                    fontSize: baseFont * 0.9,
                  ),
                ),
              ),
            ),
          ),

          // draggable sheet
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, controller) {
              final handleWidth = w * 0.2;
              final handleHeight = h * 0.01;
              final outerHandleWidth = handleWidth * 1.1;
              final outerHandleHeight = handleHeight * 1.1;
              final pillRadius = h * 0.012;
              final couponVerticalPad = h * 0.025;
              final couponHorizontalPad = w * 0.04;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(h * 0.04)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // draggable handle
                    Padding(
                      padding:
                          EdgeInsets.only(top: h * 0.002, bottom: h * 0.01),
                      child: Center(
                        child: SizedBox(
                          width: outerHandleWidth,
                          height: outerHandleHeight,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(255),
                                  borderRadius:
                                      BorderRadius.circular(outerHandleHeight),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -handleHeight * 0.3,
                                left: (outerHandleWidth - handleWidth) * 0.5,
                                child: Container(
                                  width: handleWidth,
                                  height: handleHeight,
                                  decoration: BoxDecoration(
                                    color: AppColors.blackButton,
                                    borderRadius:
                                        BorderRadius.circular(handleHeight),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
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

                    // coupon pill
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: hPad),
                      padding: EdgeInsets.symmetric(
                        horizontal: couponHorizontalPad,
                        vertical: couponVerticalPad,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(pillRadius),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF7DE47D), Color(0xFF45B649)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Coupon name',
                            style: AppText.interSemiBold(
                              color: Colors.white,
                              fontSize: baseFont * 0.9,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'DISCWITHSTARBUCK',
                            style: AppText.interSemiBold(
                              color: Colors.white,
                              fontSize: baseFont * 0.9,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.02),

                    // content
                    Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            controller: controller,
                            padding: EdgeInsets.symmetric(
                              horizontal: hPad,
                              vertical: h * 0.01,
                            ).copyWith(bottom: overlayHeight + h * 0.02),
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Delivery time',
                                    style: AppText.interSemiBold(
                                      fontSize: baseFont * 0.95,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.access_time,
                                      color: AppColors.primary,
                                      size: baseFont * 0.9),
                                  SizedBox(width: w * 0.015),
                                  Text(
                                    '30 minutes',
                                    style: AppText.interRegular(
                                      color: Colors.grey.shade700,
                                      fontSize: baseFont * 0.9,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black12,
                                ),
                              ),
                              SizedBox(height: h * 0.02),
                              Row(
                                children: [
                                  Text(
                                    'Food items',
                                    style: AppText.interSemiBold(
                                      fontSize: baseFont * 0.95,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.add,
                                      color: AppColors.text,
                                      size: baseFont * 0.9),
                                  SizedBox(width: w * 0.01),
                                  Text(
                                    'Add item',
                                    style: AppText.interMedium(
                                      color: AppColors.textDim,
                                      fontSize: baseFont * 0.9,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.015),
                              _item(
                                  'Caramel Macchiato', 1, '\$12', baseFont, w),
                              _item('Greentea Latte', 1, '\$10', baseFont, w),
                              _item('Egg Mayo Breakfast Sandwich', 2, '\$10',
                                  baseFont, w),
                              SizedBox(height: overlayHeight * 0.6),
                            ],
                          ),

                          // top subtle shadow
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white.withAlpha(240),
                                    Colors.white.withAlpha(0)
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // bottom fade overlay
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: overlayHeight,
                            height: overlayHeight * 1.5,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withAlpha(0),
                                      Colors.white.withAlpha(240),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // bottom empty safety bar
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: overlayHeight,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _item(
      String title, int qty, String price, double baseFont, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.02 * 0.4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppText.interRegular(fontSize: baseFont * 0.95),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: w * 0.03),
          Text(
            'x $qty',
            style: AppText.interRegular(
              color: AppColors.text,
              fontSize: baseFont * 0.9,
            ),
          ),
          SizedBox(width: w * 0.03),
          Text(
            price,
            style: AppText.interSemiBold(fontSize: baseFont * 0.95),
          ),
        ],
      ),
    );
  }
}
