import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      error: AppColors.errorColor,
      background: AppColors.backgroundColor,
      surface: AppColors.surfaceColor,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.textPrimaryColor),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.textPrimaryColor),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.textPrimaryColor),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.textPrimaryColor),
      titleLarge: AppTextStyles.subtitle1.copyWith(color: AppColors.textPrimaryColor),
      titleMedium: AppTextStyles.subtitle2.copyWith(color: AppColors.textPrimaryColor),
      bodyLarge: AppTextStyles.body1.copyWith(color: AppColors.textPrimaryColor),
      bodyMedium: AppTextStyles.body2.copyWith(color: AppColors.textPrimaryColor),
      labelLarge: AppTextStyles.button.copyWith(color: AppColors.textPrimaryColor),
      bodySmall: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      error: AppColors.errorColor,
      background: AppColors.backgroundDarkColor,
      surface: AppColors.surfaceDarkColor,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.textDarkPrimaryColor),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.textDarkPrimaryColor),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.textDarkPrimaryColor),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.textDarkPrimaryColor),
      titleLarge: AppTextStyles.subtitle1.copyWith(color: AppColors.textDarkPrimaryColor),
      titleMedium: AppTextStyles.subtitle2.copyWith(color: AppColors.textDarkPrimaryColor),
      bodyLarge: AppTextStyles.body1.copyWith(color: AppColors.textDarkPrimaryColor),
      bodyMedium: AppTextStyles.body2.copyWith(color: AppColors.textDarkPrimaryColor),
      labelLarge: AppTextStyles.button.copyWith(color: AppColors.textDarkPrimaryColor),
      bodySmall: AppTextStyles.caption.copyWith(color: AppColors.textDarkSecondaryColor),
    ),
  );
}
