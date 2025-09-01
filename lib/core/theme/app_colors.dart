import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color primaryLight = Color(0xFF9A82DB);
  static const Color primaryDark = Color(0xFF4A3C7E);
  
  // Secondary Colors
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color secondaryLight = Color(0xFF8B829F);
  static const Color secondaryDark = Color(0xFF443D51);
  
  // Error Colors
  static const Color errorColor = Color(0xFFBA1A1A);
  static const Color errorLight = Color(0xFFFFDAD6);
  
  // Success Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  
  // Warning Colors
  static const Color warningColor = Color(0xFFFFA726);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color yellowE0A = Color(0xFFE0A406);
  static const Color yellow5D4 = Color(0xFF5D460A);
  static const Color yellowD5B = Color(0xFFD5B46F);
  static const Color yellowFFC = Color(0xFFFFC107);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF424242);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFBFE);
  static const Color backgroundDark = Color(0xFF1C1B1F);
  static const Color surfaceLight = Color(0xFFFEF7FF);
  static const Color surfaceDark = Color(0xFF2B2930);
  static const Color black141 = Color(0xFF141313);
  static const Color greyC4C = Color(0xFFC4C7C7);
  static const Color grey2B2 = Color(0xFF2B2A2A);

  // Like/Unlike Colors
  static const Color likeColor = Color(0xFFF44336);
  static const Color unlikeColor = Color(0xFF9E9E9E);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    primaryColor,
    primaryLight,
  ];
  
  static const List<Color> authGradient = [
    Color(0xFF6750A4),
    Color(0xFF9A82DB),
  ];
  
  // Overlay Colors
  static Color overlayDark = Colors.black.withValues(alpha: 0.7);
  static Color overlayLight = Colors.black.withValues(alpha: 0.3);
  static Color overlayWhite = Colors.white.withValues(alpha: 0.9);
}