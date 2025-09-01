import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/place.dart';

class DiscountCard extends StatelessWidget {
  final Place place;
  const DiscountCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final cardW = (screenW * 0.62).clamp(220.0, 320.0); // responsive range
    return Container(
      width: cardW,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(place.imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                        child: Text(place.distanceLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12))),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(place.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(' reviews',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
