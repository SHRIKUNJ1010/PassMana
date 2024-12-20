/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_actions.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/main.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    TypedMiddleware<AppState, CheckAndManageNewUser>(_checkAndManageNewUser()).call,
  ];
}

//when splash screen is opened check if user is available or not and if user is available then
//navigate to authentication screen and if user is not available then navigate to
//get started screen which will then start registration process for user
void Function(Store<AppState> store, CheckAndManageNewUser action, NextDispatcher next) _checkAndManageNewUser() {
  return (store, action, next) {
    next(action);
    if (objectBox.userBox.hasUser()) {
      router.go(AppRoutes.authentication);
    } else {
      router.go(AppRoutes.getStarted);
    }
  };
}
