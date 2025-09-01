// category_chip.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/category.dart';

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
            width: 60,
            height: 60,
            child: ClipOval(
              child: ColoredBox(
                // placeholder while assets are ignored
                color: category.chipColor,
                child: const SizedBox.expand(),
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
                style: const TextStyle(fontSize: 12, color: AppColors.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
