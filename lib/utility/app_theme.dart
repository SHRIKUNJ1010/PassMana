/*
Created By Shrikunj on 07/01/25
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class AppTheme {
  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: AppColors.primaryColor,
        splashColor: AppColors.secondaryColor,
      );

  static ThemeData get dark => ThemeData.light().copyWith(
        primaryColor: AppColors.primaryColor,
        splashColor: AppColors.secondaryColor,
      );
}
