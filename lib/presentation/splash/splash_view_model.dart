/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'dart:async';

import 'package:passmana/domain_redux/app_actions.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:redux/redux.dart';

class SplashViewModel {
  final Function manageNavigation;

  SplashViewModel({required this.manageNavigation});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
      manageNavigation: () {
        Timer(
          const Duration(milliseconds: 2000),
          () {
            store.dispatch(CheckAndManageNewUser());
          },
        );
      },
    );
  }
}
