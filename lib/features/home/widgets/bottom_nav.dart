import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshgo/core/theme/typography.dart';
import '../../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const BottomNav({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Left and right padding
    final edgePadding = w * 0.1;

    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: edgePadding), // same padding left/right
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // evenly distribute items
            children: [
              Transform.translate(
                offset: const Offset(0, -1), // move 3 pixels up
                child:
                    _item(SvgPicture.asset("assets/icons/home.svg"), 'Home', 0),
              ),
              _item(SvgPicture.asset("assets/icons/orders.svg"), 'Orders', 1),
              _item(
                  SvgPicture.asset("assets/icons/bookmark.svg"), 'Bookmark', 2),
              _item(SvgPicture.asset("assets/icons/profile.svg"), 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(Widget icon, String label, int i) {
    final iconSize = i == index ? 18.0 : 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: iconSize,
            child: icon,
          ),
          SizedBox(height: i == 0 ? 5 : 4),
          Text(
            label,
            style: i == index
                ? AppText.interSemiBold(
                    fontSize: 12,
                    color: AppColors.primary,
                  )
                : AppText.interRegular(
                    fontSize: 12,
                    color: AppColors.textDim,
                  ),
          ),
        ],
      ),
    );
  }
}
