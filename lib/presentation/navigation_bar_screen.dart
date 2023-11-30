/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_bottom_navigation_bar.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class NavigationBarScreen extends StatefulWidget {
  final Widget child;

  const NavigationBarScreen({
    super.key,
    required this.child,
  });

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<Widget> notSelectedIconWidgets = const <Widget>[
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
  List<Widget> notSelectedTextWidgets = <Widget>[
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
  List<Widget> selectedIconWidgets = <Widget>[
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
  List<Widget> selectedTextWidgets = <Widget>[
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
  List<String> routeList = [
    AppRoutes.passwordList,
    AppRoutes.groupList,
    AppRoutes.createList,
    AppRoutes.generatePassword,
    AppRoutes.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: CustomBottomNavigationBar(
              routeList: routeList,
              notSelectedIconWidgets: notSelectedIconWidgets,
              notSelectedTextWidgets: notSelectedTextWidgets,
              selectedIconWidgets: selectedIconWidgets,
              selectedTextWidgets: selectedTextWidgets,
              selectedIndex: Utility.getCurrentIndex(),
            ),
          ),
        ],
      ),
    );
  }
}
