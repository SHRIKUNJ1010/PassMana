/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:redux/redux.dart';

class NavigationBarViewModel {
  final List<String> routeList = [
    AppRoutes.passwordList,
    AppRoutes.groupList,
    AppRoutes.createList,
    AppRoutes.generatePassword,
    AppRoutes.settings,
  ];
  final List<Widget> notSelectedIconWidgets = const <Widget>[
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
  final List<Widget> notSelectedTextWidgets = <Widget>[
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
  final List<Widget> selectedIconWidgets = <Widget>[
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
  final List<Widget> selectedTextWidgets = <Widget>[
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
  final int Function() getCurrentIndex;

  NavigationBarViewModel({
    required this.getCurrentIndex,
  });

  static NavigationBarViewModel fromStore(Store<AppState> store) {
    return NavigationBarViewModel(
      getCurrentIndex: () {
        if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.passwordList)) {
          return 0;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.groupList)) {
          return 1;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.createList)) {
          return 2;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.generatePassword)) {
          return 3;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.settings)) {
          return 4;
        } else {
          return 0;
        }
      },
    );
  }
}
