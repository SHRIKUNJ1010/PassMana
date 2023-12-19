/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:redux/redux.dart';

class NavigationBarViewModel {
  final List<String> routeList = [
    AppRoutes.passwordHomeList,
    AppRoutes.cardList,
    AppRoutes.createList,
    AppRoutes.secretNoteList,
    AppRoutes.settings,
  ];
  final List<Widget> notSelectedIconWidgets = const <Widget>[
    Icon(
      Icons.lock_outline_rounded,
      color: AppColors.mWhite,
      size: 24,
    ),
    Icon(
      FontAwesome.credit_card,
      color: AppColors.mWhite,
      size: 23,
    ),
    Icon(
      Icons.add,
      color: AppColors.mWhite,
      size: 30,
    ),
    Icon(
      Icons.note_alt_outlined,
      color: AppColors.mWhite,
      size: 28,
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
      getTranslated('card'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('create'),
      style: TextStyles.getTitleWhiteText(10),
    ),
    Text(
      getTranslated('secret_note'),
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
      FontAwesome5.credit_card,
      color: AppColors.secondaryMaterialColor[400],
      size: 22,
    ),
    const Icon(
      Icons.add,
      color: AppColors.mWhite,
      size: 30,
    ),
    Icon(
      Icons.note_alt_rounded,
      color: AppColors.secondaryMaterialColor[400],
      size: 28,
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
      getTranslated('card'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('create'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('secret_note'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
    Text(
      getTranslated('settings'),
      style: TextStyles.getTitleDarkRedText(10),
    ),
  ];
  final int Function() getCurrentIndex;
  final Function(int) onItemTap;

  NavigationBarViewModel({
    required this.getCurrentIndex,
    required this.onItemTap,
  });

  static NavigationBarViewModel fromStore(Store<AppState> store) {
    return NavigationBarViewModel(
      onItemTap: (index) {
        switch (index) {
          case 0:
            router.go(AppRoutes.passwordHomeList);
            break;
          case 1:
            router.go(AppRoutes.cardList);
            break;
          case 2:
            router.go(AppRoutes.createList);
            break;
          case 3:
            router.go(AppRoutes.secretNoteList);
            break;
          case 4:
            router.go(AppRoutes.settings);
            break;
          default:
            router.go(AppRoutes.passwordHomeList);
        }
      },
      getCurrentIndex: () {
        if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.passwordHomeList)) {
          return 0;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.cardList)) {
          return 1;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.createList)) {
          return 2;
        } else if (router.routerDelegate.currentConfiguration.fullPath.contains(AppRoutes.secretNoteList)) {
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
