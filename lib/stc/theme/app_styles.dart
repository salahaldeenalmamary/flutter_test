// lib/theme/app_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorTheme {
  static const primary = Color(0xFFC67C4E);
  static const background = Color(0xFFF9F9F9);
  static const darkBackground = Color(0xFF1F1F1F);
  static const textPrimary = Color(0xFF2F2D2C);
  static const textSecondary = Color(0xFF9B9B9B);
  static const textLight = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFFFFFFF);
  static const star = Color(0xFFFBBE21);
  static const promoTag = Color(0xFFED5151);
  static const grey = Color(0xFFEAEAEA);
}

class FontTheme {
  static TextTheme get textTheme => GoogleFonts.soraTextTheme();

  static TextStyle get heading1 => textTheme.headlineLarge!.copyWith(
        color: ColorTheme.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 34,
      );

  static TextStyle get heading2 => textTheme.headlineMedium!.copyWith(
        color: ColorTheme.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 28,
      );
      
  static TextStyle get title => textTheme.titleLarge!.copyWith(
        color: ColorTheme.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );

  static TextStyle get subtitle => textTheme.titleMedium!.copyWith(
        color: ColorTheme.textSecondary,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  static TextStyle get body => textTheme.bodyLarge!.copyWith(
        color: ColorTheme.textPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
}

class AppPaddings {
  static const double screen = 24.0;
  static const EdgeInsets allScreen = EdgeInsets.all(screen);
  static const EdgeInsets horizontalScreen = EdgeInsets.symmetric(horizontal: screen);
}

class Gap {
  static const w4 = SizedBox(width: 4);
  static const w8 = SizedBox(width: 8);
  static const w12 = SizedBox(width: 12);
  static const w16 = SizedBox(width: 16);

  static const h4 = SizedBox(height: 4);
  static const h8 = SizedBox(height: 8);
  static const h12 = SizedBox(height: 12);
  static const h16 = SizedBox(height: 16);
  static const h24 = SizedBox(height: 24);
}