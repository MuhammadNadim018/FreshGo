// lib/features/detail/detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final hPad = (w * 0.06);
    final baseFont = (w / 24);
    final overlayHeight = h * 0.045;

    // ---- Draggable sheet controller (used to programmatically change sheet extent)
    // Note: created here to keep changes minimal (you can move this into stateful
    // widget later if you want the controller to persist beyond rebuilds).
    final sheetController = DraggableScrollableController();

    // min/max sizes used for clamping when programmatically dragging
    const double minSheet = 0.3;
    const double maxSheet = 0.9;

    // helper to respond to vertical drag updates (from cutout area or black pill)
    void _handleSheetDragUpdate(DragUpdateDetails details) {
      // small guard
      if (details.primaryDelta == null) return;

      // translate pixel delta into normalized sheet extent delta
      // (dragging up yields negative primaryDelta so we subtract)
      final delta = details.primaryDelta!;
      final deltaNormalized =
          delta / h; // roughly map pixel -> fraction of screen
      final current = sheetController.size;
      final newSize = (current - deltaNormalized).clamp(minSheet, maxSheet);
      // jumpTo is instantaneous; this is fine for direct drag control.
      sheetController.jumpTo(newSize);
    }

    return Scaffold(
      body: Stack(
        children: [
          // background map
          Positioned.fill(
            child: Stack(
              children: [
                // base map covers full screen
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),

                // route line with fixed size and position
                Positioned(
                  left: w * 0.233,
                  top: h * 0.146,
                  width: w * 0.5,
                  height: h * 0.5,
                  child: SvgPicture.asset(
                    'assets/icons/map_line.svg',
                  ),
                ),

                // woman icon (top end of the line)
                Positioned(
                  left: w * 0.71,
                  top: h * 0.216,
                  child: _buildMarker('assets/icons/woman.png', w),
                ),

                // man icon (bottom end of the line)
                Positioned(
                  left: w * 0.67,
                  bottom: h * 0.39,
                  child: _buildMarker('assets/icons/man.png', w),
                ),
              ],
            ),
          ),

          // back button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blackButton,
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: h * 0.01,
                  ),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: Text(
                  'Back',
                  style: AppText.interMedium(
                    color: Colors.white,
                    fontSize: baseFont * 0.85,
                  ),
                ),
              ),
            ),
          ),

          // draggable sheet
          DraggableScrollableSheet(
            controller: sheetController,
            initialChildSize: 0.377,
            minChildSize: minSheet,
            maxChildSize: maxSheet,
            builder: (context, controller) {
              // 1. Pill hole dimensions (thinner)
              final cutoutWidth = w * 0.2;
              final cutoutHeight = h * 0.015;
              // top corner radius used by your sheet decoration (keep in sync)
              final topCornerRadius = h * 0.04;

              // 2. Black handle matches hole
              final handleWidth = cutoutWidth * 0.85;
              final handleHeight = cutoutHeight * 0.6;

              final pillHeight = h * 0.07;
              final pillRadius = h * 0.012;
              final couponVerticalPad = h * 0.02;
              final couponHorizontalPad = w * 0.04;

              // top cutout vertical offset used earlier (-4): keep same visual offset
              const double pillTopOffset = -4.0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // A. Paint top border (including cutout) on top of sheet
                  // We use foregroundPainter so the stroke sits visually above the sheet.
                  CustomPaint(
                    foregroundPainter: _SheetTopBorderPainter(
                      holeWidth: cutoutWidth,
                      holeHeight: cutoutHeight,
                      pillTopOffset: pillTopOffset,
                      cornerRadius: topCornerRadius,
                      borderColor: AppColors.border,
                      borderWidth: 1.5,
                    ),
                    child: ClipPath(
                      clipper: _SheetWithHoleClipper(
                        holeWidth: cutoutWidth,
                        holeHeight: cutoutHeight,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(topCornerRadius),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Reserve space for the hole and capture drag gestures there.
                            // Replaced your previous empty SizedBox with a SizedBox that
                            // contains an invisible GestureDetector centered over the cutout.
                            SizedBox(
                              height: cutoutHeight + h * 0.01,
                              child: Center(
                                child: GestureDetector(
                                  // This transparent detector converts drags started on the cutout
                                  // into sheet moves by talking to sheetController.
                                  behavior: HitTestBehavior.translucent,
                                  onVerticalDragUpdate: _handleSheetDragUpdate,
                                  child: SizedBox(
                                    width: cutoutWidth,
                                    height: cutoutHeight,
                                    // no decoration: purely invisible capture area
                                  ),
                                ),
                              ),
                            ),

                            // coupon pill
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hPad),
                              height: pillHeight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(pillRadius),
                                child: Stack(
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    // Background image with color filter
                                    Positioned.fill(
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.lightGreenAccent.withAlpha(80),
                                          BlendMode.hardLight,
                                        ),
                                        child: Image.asset(
                                          'assets/images/green_grass.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    // Gradient overlay
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: [
                                              Color.lerp(AppColors.primary,
                                                      Colors.greenAccent, 0.5)!
                                                  .withAlpha(150),
                                              Color.lerp(Colors.lightGreen,
                                                      Colors.greenAccent, 0.6)!
                                                  .withAlpha(150),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Foreground pill content
                                    Positioned.fill(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: couponHorizontalPad,
                                          vertical: couponVerticalPad,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Coupon name',
                                              style: AppText.interMedium(
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
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: h * 0.01),

                            // content list
                            Expanded(
                              child: Stack(
                                children: [
                                  ListView(
                                    controller: controller,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: hPad,
                                      vertical: h * 0.01,
                                    ).copyWith(
                                        bottom: overlayHeight + h * 0.02),
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Delivery time',
                                            style: AppText.interSemiBold(
                                              fontSize: baseFont * 1.04,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                            'assets/icons/clock.svg',
                                            width: baseFont * 0.98,
                                            height: baseFont * 0.98,
                                          ),
                                          SizedBox(width: baseFont * 0.5),
                                          Text(
                                            '30 minutes',
                                            style: AppText.interRegular(
                                              color: AppColors.textSecondary,
                                              fontSize: baseFont * 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h * 0.01),
                                        child: Divider(
                                            thickness: 1,
                                            color: Colors.black12),
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Row(
                                        children: [
                                          Text(
                                            'Food items',
                                            style: AppText.interSemiBold(
                                              fontSize: baseFont * 1.04,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.add,
                                              color: AppColors.text,
                                              size: baseFont * 0.9),
                                          SizedBox(width: w * 0.02),
                                          Text(
                                            'Add item',
                                            style: AppText.interRegular(
                                              color: AppColors.textSecondary,
                                              fontSize: baseFont * 0.75,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.02),
                                      _item('Caramel Macchiato', 1, '\$12',
                                          baseFont, w),
                                      _item('Greentea Latte', 1, '\$10',
                                          baseFont, w),
                                      _item('Egg Mayo Breakfast Sandwich', 2,
                                          '\$10', baseFont, w),
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
                                    height: overlayHeight * 2.8,
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

                                  // bottom safety bar
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    height: overlayHeight * 1.005,
                                    child: Container(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // B. Black pill handle inside the cutout
                  // wrap with GestureDetector so drags on the black pill also move the sheet
                  Positioned(
                    top: -cutoutHeight * 0.15,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onVerticalDragUpdate: _handleSheetDragUpdate,
                        child: Container(
                          width: handleWidth,
                          height: handleHeight,
                          decoration: BoxDecoration(
                            color: AppColors.blackButton,
                            borderRadius:
                                BorderRadius.circular(handleHeight / 2),
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
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(String asset, double w) {
    final size = w * 0.065;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: w * 0.006),
      ),
      child: ClipOval(
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static Widget _item(
      String title, int qty, String price, double baseFont, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.02 * 0.6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppText.interSemiBold(fontSize: baseFont * 0.9),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: w * 0.03),
          Text(
            '$qty x',
            style: AppText.interSemiBold(
              color: AppColors.text,
              fontSize: baseFont * 0.75,
            ),
          ),
          SizedBox(width: w * 0.03),
          Text(
            price,
            style: AppText.interRegular(
                color: AppColors.textSecondary, fontSize: baseFont * 0.75),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for pill-shaped hole (unchanged logic)
class _SheetWithHoleClipper extends CustomClipper<Path> {
  final double holeWidth;
  final double holeHeight;

  _SheetWithHoleClipper({
    required this.holeWidth,
    required this.holeHeight,
  });

  @override
  Path getClip(Size size) {
    // Full sheet
    final sheetPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Pill-shaped hole at top center (same offset you were using)
    final left = (size.width - holeWidth) / 2;
    final rect = Rect.fromLTWH(left, -4, holeWidth, holeHeight);
    final pillPath = Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(holeHeight / 2)));

    // Subtract pill from sheet
    return Path.combine(PathOperation.difference, sheetPath, pillPath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => false;
}

// Painter that draws the sheet top border + cutout outline
class _SheetTopBorderPainter extends CustomPainter {
  final double holeWidth;
  final double holeHeight;
  final double pillTopOffset; // e.g. -4.0 used in clipper
  final double cornerRadius; // top corner radius of the sheet decoration
  final Color borderColor;
  final double borderWidth;

  _SheetTopBorderPainter({
    required this.holeWidth,
    required this.holeHeight,
    required this.pillTopOffset,
    required this.cornerRadius,
    this.borderColor = AppColors.border,
    this.borderWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final cutoutLeft = (size.width - holeWidth) / 2;
    final cutoutRight = cutoutLeft + holeWidth;

    // We'll build a path that walks the visible top edge of the sheet:
    // top-left rounded corner -> top edge to cutout -> outline around the pill
    // -> continue to top-right corner.
    final path = Path();

    // start at top-left corner's leftmost arc entry
    path.moveTo(0, cornerRadius);
    // top-left corner arc (quadratic)
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // top edge to left edge of cutout
    path.lineTo(cutoutLeft, 0);

    // arc downwards along the left pill semicircle (from top edge to pill bottom)
    path.arcToPoint(
      Offset(cutoutLeft + (holeHeight / 2), pillTopOffset + holeHeight),
      radius: Radius.circular(holeHeight / 2),
      clockwise: true,
    );

    // bottom of pill (straight)
    path.lineTo(cutoutRight - (holeHeight / 2), pillTopOffset + holeHeight);

    // arc upwards along the right pill semicircle (from pill bottom back to top)
    path.arcToPoint(
      Offset(cutoutRight, 0),
      radius: Radius.circular(holeHeight / 2),
      clockwise: true,
    );

    // continue top edge to right corner
    path.lineTo(size.width - cornerRadius, 0);
    // top-right corner arc
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
