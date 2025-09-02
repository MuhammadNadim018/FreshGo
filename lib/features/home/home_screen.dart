import 'package:flutter/material.dart';
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
      imagePath: 'assets/images/beverage.png',
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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      bottomNavigationBar:
          BottomNav(index: index, onTap: (i) => setState(() => index = i)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(child: _search(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: _banner(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: _sectionTitle(context, 'Top Categories')),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: (MediaQuery.sizeOf(context).height * 0.12)
                      .clamp(88.0, 112.0),
                  width: MediaQuery.sizeOf(context).width,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => CategoryChip(category: categories[i]),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: _sectionTitle(context, 'Top Discount')),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: places.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (_, i) => DiscountCard(
                    key: ValueKey(places[i].title),
                    place: places[i],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 18),
                  const SizedBox(width: 4),
                  Text('Current location',
                      style: AppText.interRegular(
                          color: AppColors.textDim, fontSize: 12)),
                ]),
                const SizedBox(height: 4),
                Text('Jl. Soekarno Hatta 15A...',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.interSemiBold(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 40,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2))
                  ]),
              child: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.card,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12, right: 5),
            child: Icon(Icons.search, size: 20, color: Colors.grey),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, size: 20, color: Colors.grey),
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          hintText: 'Search menu, restaurant or etc',
          hintStyle: AppText.interRegular(
            color: AppColors.textDim,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: AspectRatio(
        aspectRatio: 327 / 142,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get actual banner dimensions
            final bannerWidth = constraints.maxWidth;
            final bannerHeight = constraints.maxHeight;

            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                clipBehavior: Clip.hardEdge, // prevent overflow
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/green_grass.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Semi-transparent overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            AppColors.primary.withAlpha(230),
                            AppColors.primaryDark.withAlpha(230),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Text & button
                  Positioned(
                    left: bannerWidth * 0.05, // 4% from left
                    top: 0,
                    bottom: 0,
                    width: bannerWidth * 0.51, // 51% of banner width
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Claim your\ndiscount 30%\ndaily now!',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.interSemiBold(
                            color: Colors.white,
                            fontSize: bannerWidth * 0.05, // 4% of banner width
                          ),
                        ),
                        SizedBox(
                            height: bannerHeight * 0.04), // 8% of banner height
                        SizedBox(
                          height: bannerHeight * 0.2, // 25% of banner height
                          child: FilledButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(place: places[0]),
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: bannerWidth * 0.06,
                                vertical: bannerHeight * 0.005,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Order now',
                              style: AppText.sfProSemiBold(
                                color: Colors.white,
                                fontSize:
                                    bannerWidth * 0.033, // 3% of banner width
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Flipped overlay image - positioned relative to banner
                  Positioned(
                    right: bannerWidth * 0.16, // 2% from right edge
                    bottom: bannerHeight * 0.0, // 10% from bottom
                    child: Transform.scale(
                      scaleX: -1.0,
                      child: SizedBox(
                        width: bannerWidth * 0.415, // 35% of banner width
                        height: bannerHeight * 0.92, // 80% of banner height
                        child: Image.asset(
                          'assets/images/ice_cream.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Pagination pill - positioned relative to banner
                  Positioned(
                    bottom: bannerHeight * 0.09, // 8% from bottom
                    right: bannerWidth * 0.05, // 5% from right
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: bannerWidth * 0.03, // 3% of banner width
                        vertical: bannerHeight * 0.06, // 4% of banner height
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(bannerHeight * 0.08),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (i) {
                          final active = i == 0;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: bannerWidth * 0.008),
                            child: Container(
                              width:
                                  bannerWidth * 0.038, // 2.5% of banner width
                              height:
                                  bannerHeight * 0.03, // 5% of banner height
                              decoration: BoxDecoration(
                                color: active
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
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
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
      child: Row(
        children: [
          Text(title, style: AppText.interSemiBold(fontSize: 16)),
          const Spacer(),
          Text('See all',
              style: AppText.interSemiBold(
                  color: AppColors.textDim, fontSize: 12)),
        ],
      ),
    );
  }
}
