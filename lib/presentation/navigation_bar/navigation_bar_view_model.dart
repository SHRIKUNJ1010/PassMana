/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:redux/redux.dart';

class NavigationBarViewModel {
  final List<String> routeList;
  final List<Widget> notSelectedIconWidgets;
  final List<Widget> notSelectedTextWidgets;

  final List<Widget> selectedIconWidgets;

  final List<Widget> selectedTextWidgets;

  final int Function() getCurrentIndex;
  final Function(int) onItemTap;

  NavigationBarViewModel({
    required this.getCurrentIndex,
    required this.onItemTap,
    required this.routeList,
    required this.notSelectedIconWidgets,
    required this.selectedTextWidgets,
    required this.notSelectedTextWidgets,
    required this.selectedIconWidgets,
  });

  static NavigationBarViewModel fromStore(Store<AppState> store, BuildContext context) {
    return NavigationBarViewModel(
      routeList: [
        AppRoutes.passwordHomeList,
        AppRoutes.cardList,
        AppRoutes.createList,
        AppRoutes.secretNoteList,
        AppRoutes.settings,
      ],
      notSelectedIconWidgets: <Widget>[
        Icon(
          Icons.lock_outline_rounded,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 24,
        ),
        Icon(
          FontAwesome.credit_card,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 23,
        ),
        Icon(
          Icons.add,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 30,
        ),
        Icon(
          Icons.note_alt_outlined,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 28,
        ),
        Icon(
          Icons.settings_outlined,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 25,
        ),
      ],
      selectedIconWidgets: <Widget>[
        Icon(
          Icons.lock,
          color: Theme.of(context).textTheme.displayLarge?.color,
          size: 24,
        ),
        Icon(
          FontAwesome5.credit_card,
          color: Theme.of(context).textTheme.displayLarge?.color,
          size: 22,
        ),
        Icon(
          Icons.add,
          color: Theme.of(context).textTheme.displaySmall?.color,
          size: 30,
        ),
        Icon(
          Icons.note_alt_rounded,
          color: Theme.of(context).textTheme.displayLarge?.color,
          size: 28,
        ),
        Icon(
          Icons.settings,
          color: Theme.of(context).textTheme.displayLarge?.color,
          size: 25,
        )
      ],
      notSelectedTextWidgets: <Widget>[
        Text(
          getTranslated('password', context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 11),
        ),
        Text(
          getTranslated('card', context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 11),
        ),
        Text(
          getTranslated('create', context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 11),
        ),
        Text(
          getTranslated('secret_note', context),
          style: TextStyles.getTitleWhiteText(11),
        ),
        Text(
          getTranslated('settings', context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 11),
        ),
      ],
      selectedTextWidgets: <Widget>[
        Text(
          getTranslated('password', context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 12),
        ),
        Text(
          getTranslated('card', context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 12),
        ),
        Text(
          getTranslated('create', context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 12),
        ),
        Text(
          getTranslated('secret_note', context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 12),
        ),
        Text(
          getTranslated('settings', context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 12),
        ),
      ],
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
