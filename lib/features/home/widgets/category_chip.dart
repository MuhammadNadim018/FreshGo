// category_chip.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/category.dart';
import '../../../core/theme/typography.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 74, maxWidth: 90),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: ClipOval(
              child: Image.asset(
                category
                    .imagePath, // your path, e.g. 'assets/images/beverage.png'
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    ColoredBox(color: category.chipColor),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 16, // one line
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                    AppText.interSemiBold(color: AppColors.text, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
