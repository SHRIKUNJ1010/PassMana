/*
* Created by Shrikunj Patel on 11/24/2023.
*/

import 'package:passmana/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:passmana/utility/text_utility/fonts_list.dart';

class TextStyles {
  static TextStyle? buttonWhiteText = const TextStyle(
    color: AppColors.mWhite,
    fontSize: 16,
    fontFamily: FontsList.muli,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );

  static TextStyle? titleRedText = const TextStyle(
    color: AppColors.accentSecondaryColor,
    fontSize: 42,
    fontWeight: FontWeight.w400,
    fontFamily: FontsList.muli,
    decoration: TextDecoration.none,
  );

  static TextStyle? titleWhiteText = const TextStyle(
    color: AppColors.mWhite,
    fontSize: 42,
    fontWeight: FontWeight.w400,
    fontFamily: FontsList.muli,
    decoration: TextDecoration.none,
  );
}
//ac244b
