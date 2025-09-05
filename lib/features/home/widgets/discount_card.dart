// lib/features/home/widgets/discount_card.dart
import 'package:flutter/material.dart';
import 'package:freshgo/core/theme/typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/place.dart';

class DiscountCard extends StatelessWidget {
  final Place place;
  const DiscountCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final iconBox = (w * 0.042);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW = constraints.maxWidth;
        // maintain image aspect ratio
        final imageH = cardW * (108 / 153);
        final textSpacing = 4.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: imageH,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(place.imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: textSpacing * 3.0),
            // Title
            Text(
              place.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.interSemiBold(fontSize: w * 0.038),
            ),
            SizedBox(height: textSpacing / 2),
            // Row with distance and rating
            Row(
              children: [
                Text(
                  place.distanceLabel,
                  style: AppText.interRegular(
                      color: AppColors.textDim, fontSize: w * 0.033),
                ),
                SizedBox(width: w * 0.02),
                Text(
                  '•',
                  style: AppText.interRegular(
                      color: AppColors.border, fontSize: w * 0.033),
                ),
                SizedBox(width: w * 0.015),
                Image.asset(
                  'assets/icons/star.png',
                  height: iconBox,
                  width: iconBox,
                ),
                SizedBox(width: w * 0.01),
                Flexible(
                  child: Text(
                    '${place.rating.toStringAsFixed(1)} reviews',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.interRegular(
                        color: AppColors.textDim, fontSize: w * 0.033),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
