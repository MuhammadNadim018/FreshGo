// lib/core/theme/typography.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  // Inter Regular (400)
  static TextStyle interRegular({
    Color color = Colors.black,
    double fontSize = 14,
  }) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      );

  // Inter Medium (500)
  static TextStyle interMedium({
    Color color = Colors.black,
    double fontSize = 16,
  }) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color,
      );

  // Inter SemiBold (600)
  static TextStyle interSemiBold({
    Color color = Colors.black,
    double fontSize = 18,
  }) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
      );

  // SF Pro SemiBold (590+10, only multiple of 100 is supported) – custom asset font
  static TextStyle sfProSemiBold({
    Color color = Colors.white,
    double fontSize = 16,
  }) =>
      const TextStyle(
        fontFamily: 'SFPro',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white,
      ).copyWith(color: color, fontSize: fontSize);
}
