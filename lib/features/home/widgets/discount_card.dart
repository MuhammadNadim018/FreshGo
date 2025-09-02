import 'package:flutter/material.dart';
import 'package:freshgo/core/theme/typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/place.dart';

class DiscountCard extends StatelessWidget {
  final Place place;
  const DiscountCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final cardW = (screenW * 0.45).clamp(220.0, 220.0); // responsive range

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card holds only the image
        Container(
          width: cardW,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16), bottom: Radius.circular(16)),
              child: Image.asset(place.imagePath, fit: BoxFit.cover),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Texts outside the card
        SizedBox(
          width: cardW,
          child: Text(
            place.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.interSemiBold(fontSize: 14),
          ),
        ),

        const SizedBox(height: 4),

        Row(
          children: [
            SizedBox(
              width: cardW * 0.4,
              child: Text(
                place.distanceLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.interRegular(
                    color: AppColors.textDim, fontSize: 12),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              place.rating.toStringAsFixed(1),
              style:
                  AppText.interRegular(color: AppColors.textDim, fontSize: 12),
            ),
            Text(
              ' reviews',
              style:
                  AppText.interRegular(color: AppColors.textDim, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
