import 'package:flutter/material.dart';
import 'app_colors.dart';

class T {
  static TextStyle h1(BuildContext c) =>
      Theme.of(c).textTheme.headlineSmall!.copyWith(
          color: AppColors.text, fontWeight: FontWeight.w800, height: 1.15);
  static TextStyle bodyDim(BuildContext c) => Theme.of(c)
      .textTheme
      .bodyMedium!
      .copyWith(color: AppColors.textDim, height: 1.35);
}
