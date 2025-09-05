import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/typography.dart';
import '../../models/category.dart';
import '../../models/place.dart';
import 'widgets/category_chip.dart';
import 'widgets/discount_card.dart';
import 'widgets/bottom_nav.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final categories = const [
    Category(
      title: 'Beverages',
      imagePath: 'assets/images/beverages.png',
      chipColor: Color(0xFFE8F5E9),
    ),
    Category(
      title: 'Snack',
      imagePath: 'assets/images/snack.png',
      chipColor: Color(0xFFFFF3E0),
    ),
    Category(
      title: 'Seafood',
      imagePath: 'assets/images/seafood.png',
      chipColor: Color(0xFFFFEBEE),
    ),
    Category(
      title: 'Dessert',
      imagePath: 'assets/images/dessert.png',
      chipColor: Color(0xFFE8F5E9),
    ),
  ];

  final places = const [
    Place(
      title: 'Starbuck Borobudur',
      distanceLabel: '1.0 km',
      rating: 4.8,
      imagePath: 'assets/images/td1.png',
    ),
    Place(
      title: 'Baegopa Suhat',
      distanceLabel: '500 m',
      rating: 4.8,
      imagePath: 'assets/images/td2.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;

    final hPad = w * 0.06; // horizontal padding
    final baseFont = w / 24; // base font size

    return Scaffold(
      backgroundColor: AppColors.bg,
      bottomNavigationBar:
          BottomNav(index: index, onTap: (i) => setState(() => index = i)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header(context, hPad)),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.015)),
            SliverToBoxAdapter(child: _search(context, hPad)),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.025)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: _banner(context),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.035)),
            // Top Categories
            SliverToBoxAdapter(
              child: _sectionTitle(context, 'Top Categories', hPad, baseFont),
            ),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.01)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad * 0.9),
                child: Row(
                  children: categories.map((cat) {
                    final isLast = cat == categories.last;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: isLast ? 0 : w * 0.01),
                        child: CategoryChip(category: cat),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.025)),
            // Top Discount
            SliverToBoxAdapter(
              child: _sectionTitle(context, 'Top Discount', hPad, baseFont),
            ),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.01)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: LayoutBuilder(builder: (ctx, cons) {
                  final totalW = cons.maxWidth;
                  final spacing = w * 0.05; // space between cards
                  final cardW =
                      (totalW - (places.length - 1) * spacing) / places.length;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 0; i < places.length; i++) ...[
                        SizedBox(
                          width: cardW,
                          child: DiscountCard(place: places[i]),
                        ),
                        if (i < places.length - 1) SizedBox(width: spacing),
                      ]
                    ],
                  );
                }),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: h * 0.03)),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, double hPad) {
    final w = MediaQuery.of(context).size.width;
    final iconBox = (w * 0.1).clamp(32.0, 48.0);
    final iconTextGap = w * 0.03;
    final labelFont = (iconBox * 0.33);
    final addressFont = (iconBox * 0.4);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, iconBox * 0.75, hPad, iconBox * 0.25),
      child: Row(
        children: [
          Container(
            width: iconBox,
            height: iconBox,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(iconBox * 0.15),
            ),
            child: Center(
              child: Transform.scale(
                scale: 1.2,
                child: SvgPicture.asset(
                  'assets/icons/map_pin.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: iconTextGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Current location',
                      style: AppText.interRegular(
                        color: AppColors.textSecondary,
                        fontSize: labelFont,
                      ),
                    ),
                    SizedBox(width: w * 0.015),
                    Icon(
                      Icons.arrow_drop_down,
                      size: labelFont * 1.3,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                SizedBox(height: iconTextGap * 0.5),
                Text(
                  'Jl. Soekarno Hatta 15A \'this is extra text\'',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.interSemiBold(
                    fontSize: addressFont,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: iconTextGap),
          Container(
            width: iconBox,
            height: iconBox,
            decoration: BoxDecoration(
              color: AppColors.textDim.withAlpha(25),
              borderRadius: BorderRadius.circular(iconBox * 0.15),
            ),
            child: Center(
              child: Transform.scale(
                scale: 1.2,
                child: SvgPicture.asset(
                  'assets/icons/dot_bell_notification_outline.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _search(BuildContext context, double hPad) {
    final w = MediaQuery.of(context).size.width;
    final height = (w * 0.08).clamp(48.0, 64.0);
    final iconSize = height * 0.38;
    final gap = height * 0.25;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(height * 0.5),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            SizedBox(width: gap * 1.5),
            SvgPicture.asset(
              'assets/icons/search.svg',
              height: iconSize,
              width: iconSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: gap),
            Expanded(
              child: TextField(
                style: AppText.interRegular(color: AppColors.text),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Search menu, restaurant or etc',
                  hintStyle: AppText.interRegular(
                    color: AppColors.textDim,
                    fontSize: height * 0.27,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/filter.svg',
              height: iconSize,
              width: iconSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: gap * 1.5),
          ],
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return AspectRatio(
      aspectRatio: 327 / 142,
      child: LayoutBuilder(
        builder: (ctx, cons) {
          final bwLocal = cons.maxWidth;
          final bh = cons.maxHeight;
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
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
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color.lerp(
                                  AppColors.primary, Colors.greenAccent, 0.5)!
                              .withAlpha(150),
                          Color.lerp(
                                  Colors.lightGreen, Colors.greenAccent, 0.6)!
                              .withAlpha(150),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: bwLocal * 0.05,
                  top: 0,
                  bottom: 0,
                  width: bwLocal * 0.51,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Claim your\ndiscount 30%\ndaily now!',
                        style: AppText.interSemiBold(
                          color: Colors.white,
                          fontSize: bwLocal * 0.05,
                        ).copyWith(height: 1.17),
                      ),
                      SizedBox(height: bh * 0.06),
                      SizedBox(
                        height: bh * 0.21,
                        child: FilledButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(place: places[0]),
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.blackButton,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: bwLocal * 0.045,
                              vertical: bh * 0.008,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Order now',
                            style: AppText.sfProSemiBold(
                              fontSize: bwLocal * 0.035,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: bwLocal * -0.05,
                  child: SizedBox(
                    width: bwLocal * 0.8,
                    height: bh * 1.0,
                    child: Image.asset(
                      'assets/images/ice_cream.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: bh * 0.09,
                  right: bwLocal * 0.05,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: bwLocal * 0.031,
                      vertical: bh * 0.055,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(bh * 0.08),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) {
                        final active = i == 0;
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: bwLocal * 0.006),
                          child: Container(
                            width: bwLocal * 0.036,
                            height: bh * 0.03,
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(bh * 0.08),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(
      BuildContext context, String title, double hPad, double baseFont) {
    final seeAllFont = (MediaQuery.of(context).size.width * 0.033);
    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 0, hPad, hPad * 0.3),
      child: Row(
        children: [
          Text(title, style: AppText.interSemiBold(fontSize: baseFont * 1.1)),
          Spacer(),
          Text(
            'See all',
            style: AppText.interSemiBold(
                color: AppColors.textDimmer, fontSize: seeAllFont),
          ),
        ],
      ),
    );
  }
}
