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
        imagePath: 'assets/images/cat_beverage.png',
        chipColor: Color(0xFFE8F5E9)),
    Category(
        title: 'Snack',
        imagePath: 'assets/images/cat_snack.png',
        chipColor: Color(0xFFFFF3E0)),
    Category(
        title: 'Seafood',
        imagePath: 'assets/images/cat_seafood.png',
        chipColor: Color(0xFFFFEBEE)),
    Category(
        title: 'Dessert',
        imagePath: 'assets/images/cat_dessert.png',
        chipColor: Color(0xFFE8F5E9)),
  ];

  final places = const [
    Place(
        title: 'Starbuck Borobudur',
        distanceLabel: '1.0 km',
        rating: 4.8,
        imagePath: 'assets/images/p1.jpg'),
    Place(
        title: 'Baegopa Suhat',
        distanceLabel: '500 m',
        rating: 4.8,
        imagePath: 'assets/images/p2.jpg'),
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
                height:
                    250, // fixed height that covers image + text comfortably
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: places.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.textDim)),
                ]),
                const SizedBox(height: 4),
                Text('Jl. Soekarno Hatta 15A...',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.card,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.tune),
          hintText: 'Search menu, restaurant or etc',
          hintStyle: TextStyle(color: AppColors.textDim),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 343 / 120, // keeps promo proportions across devices
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text('Claim your\ndiscount 30%\ndaily now!',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(place: places[0]),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 34),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: const StadiumBorder()),
                      child: const Text('Order now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/ice_cream.png',
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const Spacer(),
          Text('See all', style: TextStyle(color: AppColors.textDim)),
        ],
      ),
    );
  }
}
