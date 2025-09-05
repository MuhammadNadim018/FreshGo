// lib/features/home/widgets/category_chip.dart
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/category.dart';
import '../../../core/theme/typography.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Make chips smaller - 13% of screen width, clamped between 50-65px
    final chipSize = (w * 0.17); //.clamp(50.0, 65.0);
    // Font size proportional to chip, smaller range
    final fontSize = (chipSize * 0.22); //.clamp(11.0, 13.0);
    // Smaller gap between image and text
    final gap = chipSize * 0.08;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular image
        SizedBox(
          width: chipSize,
          height: chipSize,
          child: ClipOval(
            child: Image.asset(
              category.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  ColoredBox(color: category.chipColor),
            ),
          ),
        ),
        SizedBox(height: gap),
        // Text with fixed width container to prevent overflow
        SizedBox(
          width: chipSize * 1.4, // Slightly wider than chip for text
          child: Text(
            category.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppText.interSemiBold(
              fontSize: fontSize,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
