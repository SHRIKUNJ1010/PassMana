/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUserMiddleware() {
  return [
    TypedMiddleware<AppState, CreateUser>(_createUser()),
    TypedMiddleware<AppState, UpdatePin>(_updatePin()),
    TypedMiddleware<AppState, UpdateMasterPassword>(_updateMasterPassword()),
  ];
}

void Function(Store<AppState> store, CreateUser action, NextDispatcher next) _createUser() {
  return (store, action, next) {
    next(action);
  };
}

void Function(Store<AppState> store, UpdatePin action, NextDispatcher next) _updatePin() {
  return (store, action, next) {
    next(action);
  };
}

void Function(Store<AppState> store, UpdateMasterPassword action, NextDispatcher next) _updateMasterPassword() {
  return (store, action, next) {
    next(action);
  };
}
