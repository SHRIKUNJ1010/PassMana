/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class AppConstants {
  //language constants
  static const String english = 'en';
  static const String hindi = 'hi';
  static const String gujarati = 'gu';

  //hero animation tags
  static const String appLogo = "appLogo";


  //navigation bar screen constants
  static List<Widget> bottomNavigationNotSelectedIconWidgets = const <Widget>[
    Icon(
      Icons.lock_outline_rounded,
      color: AppColors.mWhite,
      size: 24,
    ),
    Icon(
      Icons.people_outline,
      color: AppColors.mWhite,
      size: 30,
    ),
    Icon(
      Icons.add,
      color: AppColors.mWhite,
      size: 30,
    ),
    Icon(
      Icons.alt_route,
      color: AppColors.mWhite,
      size: 22,
    ),
    Icon(
      Icons.settings_outlined,
      color: AppColors.mWhite,
      size: 25,
    ),
  ];
  static List<Widget> bottomNavigationNotSelectedTextWidgets = <Widget>[
    Text(
      getTranslated('password'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('group'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('create'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('generate'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('settings'),
      style: TextStyles.getTitleWhiteText(10),
    ),
  ];
  static List<Widget> bottomNavigationSelectedIconWidgets = <Widget>[
    Icon(
      Icons.lock,
      color: AppColors.secondaryMaterialColor[400],
      size: 24,
    ),
    Icon(
      Icons.people,
      color: AppColors.secondaryMaterialColor[400],
      size: 30,
    ),
    const Icon(
      Icons.add,
      color: AppColors.mWhite,
      size: 30,
    ),
    Icon(
      Icons.alt_route,
      color: AppColors.secondaryMaterialColor[400],
      size: 22,
    ),
    Icon(
      Icons.settings,
      color: AppColors.secondaryMaterialColor[400],
      size: 25,
    )
  ];
  static List<Widget> bottomNavigationSelectedTextWidgets = <Widget>[
    Text(
      getTranslated('password'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('group'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('create'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('generate'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('settings'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
  ];
  static List<String> bottomNavigationRouteList = [
    AppRoutes.passwordList,
    AppRoutes.groupList,
    AppRoutes.createList,
    AppRoutes.generatePassword,
    AppRoutes.settings,
  ];
}