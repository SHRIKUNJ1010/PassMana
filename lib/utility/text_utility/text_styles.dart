/*
* Created by Shrikunj Patel on 11/24/2023.
*/

import 'package:passmana/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:passmana/utility/text_utility/fonts_list.dart';

class TextStyles {
  static TextStyle? getButtonWhiteText(double fontSize) => TextStyle(
        color: AppColors.mWhite,
        fontSize: fontSize,
        fontFamily: FontsList.muli,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      );

  static TextStyle? getTitleRedText(double fontSize) => TextStyle(
        color: AppColors.accentSecondaryColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: FontsList.muli,
        decoration: TextDecoration.none,
      );

  static TextStyle? getTitleDarkRedText(double fontSize) => TextStyle(
        color: AppColors.secondaryMaterialColor[400],
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontFamily: FontsList.muli,
        decoration: TextDecoration.none,
      );

  static TextStyle? getTitleWhiteText(double fontSize) => TextStyle(
        color: AppColors.mWhite,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: FontsList.muli,
        decoration: TextDecoration.none,
      );

  static TextStyle? getTitleTransparentBlackText({
    required double fontSize,
    required double opacity,
  }) =>
      TextStyle(
        color: AppColors.mBlack.withOpacity(opacity),
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: FontsList.muli,
        decoration: TextDecoration.none,
      );
}
//ac244b
