import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const BottomNav({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        decoration: const BoxDecoration(color: AppColors.card, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(Ionicons.home_outline, Ionicons.home, 'Home', 0),
            _item(Ionicons.receipt_outline, Ionicons.receipt, 'Orders', 1),
            _item(Ionicons.bookmark_outline, Ionicons.bookmark, 'Bookmark', 2),
            _item(Ionicons.person_outline, Ionicons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _item(
      IconData outlinedIcon, IconData filledIcon, String label, int i) {
    final selected = index == i;
    final color = selected ? AppColors.primary : Colors.grey;
    return InkWell(
      onTap: () => onTap(i),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? filledIcon : outlinedIcon,
              color: color,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
            if (selected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
