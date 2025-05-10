import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF5A401A);
  static const Color secondary = Color(0x825A401A);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF424242);
  static const Color danger = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFF30A);
  static const Color info = Color(0xFF1962FF);
  static const Color success = Color(0xFF38AC51);
}

class AppTextSizes {
  static const double heading1 = 42.0;
  static const double heading2 = 20.0;
  static const double heading3 = 16.0;
  static const double body = 14.0;
  static const double small = 12.0;
  static const double caption = 10.0;
}

class AppFonts {
  static const String kanit = 'Kanit';
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: AppTextSizes.heading1,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: AppFonts.kanit,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: AppTextSizes.heading2,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: AppFonts.kanit,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: AppTextSizes.heading3,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: AppFonts.kanit,
  );

  static const TextStyle body = TextStyle(
    fontSize: AppTextSizes.body,
    color: AppColors.textPrimary,
    fontFamily: AppFonts.kanit,
  );

  static const TextStyle small = TextStyle(
    fontSize: AppTextSizes.small,
    color: AppColors.textSecondary,
    fontFamily: AppFonts.kanit,
  );
}

class AppButtonStyles {
  static ButtonStyle elevatedButtonPrimary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
    shape: StadiumBorder(),
    elevation: 0,
  );

  static ButtonStyle outlinedButtonPrimary = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.primary,
    overlayColor: AppColors.primary,
    side: BorderSide(width: 2, color: AppColors.primary),
    textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
    shape: StadiumBorder(),
    elevation: 0,
  );
}
