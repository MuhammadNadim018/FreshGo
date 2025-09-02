import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/place.dart';

class DetailScreen extends StatelessWidget {
  final Place place;
  const DetailScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    //final horizontalPadding = screenWidth * 0.06; // 6% of width
    final verticalImageScale = 1.0;
    //final bottomSheetMaxHeight =
        screenHeight * (screenHeight < 720 ? 0.72 : 0.56);
    //final bottomSheetMinHeight = screenHeight * 0.42;
    // Text scale factor
    //final baseFont = screenWidth / 24;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
                child: ClipRect(
                  child: Transform.scale(
                    scale: verticalImageScale,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.fitWidth,
                      width: screenWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.text,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8)),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label:
                    const Text('Back', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: const Offset(0, -4))
                  ],
                ),
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                        child: Container(
                            width: 42,
                            height: 4,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(2)))),
                    //const SizedBox(height: 14),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Delivery time',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        const Spacer(),
                        const Icon(Icons.access_time,
                            color: AppColors.primary, size: 16),
                        const SizedBox(width: 6),
                        Text('30 minutes',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Text('Food items',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        Spacer(),
                        Icon(Icons.add, color: AppColors.text, size: 18),
                        SizedBox(width: 4),
                        Text('Add item',
                            style: TextStyle(
                                color: AppColors.textDim,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _item('Caramel Macchiato', 1, '\$12'),
                    _item('Greentea Latte', 1, '\$10'),
                    _item('Egg Mayo Breakfast Sandwich', 2, '\$10'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _item(String title, int qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
          Text('x $qty', style: TextStyle(color: AppColors.text)),
          const SizedBox(width: 12),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
