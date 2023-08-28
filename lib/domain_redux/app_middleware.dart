/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/app_actions.dart';
import 'package:passmana/main.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    TypedMiddleware<AppState, CheckAndManageNewUser>(_checkAndManageNewUser()),
  ];
}

void Function(Store<AppState> store, CheckAndManageNewUser action, NextDispatcher next) _checkAndManageNewUser() {
  return (store, action, next) {
    next(action);
    if (objectBox.hasUser()) {
      //todo: navigate to enter pin screen / biometric check screen
    } else {
      //todo: navigate to get started screen to generate master password and mobile pin
    }
  };
}
