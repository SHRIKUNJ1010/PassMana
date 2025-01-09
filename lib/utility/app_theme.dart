/*
Created By Shrikunj on 07/01/25
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/fonts_list.dart';

class AppTheme {
  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: AppColors.primaryColor,
        primaryColorLight: AppColors.accentPrimaryColor,
        splashColor: AppColors.accentSecondaryColor,
        cardColor: AppColors.mWhite,
        cardTheme: CardTheme(
          color: AppColors.primaryColor,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
          ),
          backgroundColor: AppColors.primaryMaterialColor[300],
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: FontsList.muli,
          ),
          displayMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          displaySmall: TextStyle(
            color: AppColors.mWhite,
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            color: AppColors.mWhite,
            fontWeight: FontWeight.bold,
            fontFamily: FontsList.muli,
          ),
          bodyMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          bodySmall: TextStyle(
            color: AppColors.mBlack.withValues(alpha: 0.8),
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          headlineMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          headlineSmall: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          labelMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          labelSmall: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleSmall: TextStyle(
            fontFamily: FontsList.muli,
          ),
        ),
      );

  static ThemeData get dark => ThemeData.light().copyWith(
        primaryColor: AppColors.primaryDarkColor,
        primaryColorLight: AppColors.accentPrimaryDarkColor,
        splashColor: AppColors.accentSecondaryDarkColor,
        cardColor: AppColors.mGrey,
        cardTheme: CardTheme(
          color: AppColors.primaryLightColor,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.mE0E0E0,
          ),
          backgroundColor: AppColors.primaryDarkColor,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: AppColors.accentSecondaryAlternateColor,
            fontWeight: FontWeight.bold,
            fontFamily: FontsList.muli,
          ),
          displayMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          displaySmall: TextStyle(
            color: AppColors.mE0E0E0,
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            color: AppColors.mE0E0E0,
            fontWeight: FontWeight.bold,
            fontFamily: FontsList.muli,
          ),
          bodyMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          bodySmall: TextStyle(
            color: AppColors.mE0E0E0,
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          headlineMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          headlineSmall: TextStyle(
            color: AppColors.mE0E0E0,
            fontFamily: FontsList.muli,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          labelMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          labelSmall: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleLarge: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleMedium: TextStyle(
            fontFamily: FontsList.muli,
          ),
          titleSmall: TextStyle(
            fontFamily: FontsList.muli,
          ),
        ),
      );
}
