/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/user_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUserMiddleware() {
  return [
    TypedMiddleware<AppState, CreateUser>(_createUser()),
    TypedMiddleware<AppState, UpdatePin>(_updatePin()),
    TypedMiddleware<AppState, UpdateMasterPassword>(_updateMasterPassword()),
    TypedMiddleware<AppState, SwitchBiometricOption>(_switchBiometricOption()),
  ];
}

void Function(Store<AppState> store, CreateUser action, NextDispatcher next) _createUser() {
  return (store, action, next) {
    next(action);
    objectBox.userBox.changeCreateMasterPassword(action.masterPassword);
    objectBox.userBox.changeCreatePin(action.pin);
    store.dispatch(
      UserChanged(
        user: User(
          masterPassword: action.masterPassword,
          pin: action.pin,
        ),
      ),
    );
  };
}

void Function(Store<AppState> store, UpdatePin action, NextDispatcher next) _updatePin() {
  return (store, action, next) {
    next(action);
    objectBox.userBox.changeCreatePin(action.pin);
    store.dispatch(
      UserChanged(
        user: store.state.user?.setPin(action.pin),
      ),
    );
  };
}

void Function(Store<AppState> store, UpdateMasterPassword action, NextDispatcher next) _updateMasterPassword() {
  return (store, action, next) {
    next(action);
    objectBox.userBox.changeCreateMasterPassword(action.masterPassword);
    store.dispatch(
      UserChanged(
        user: store.state.user?.setMasterPassword(action.masterPassword),
      ),
    );
  };
}

void Function(Store<AppState> store, SwitchBiometricOption action, NextDispatcher next) _switchBiometricOption() {
  return (store, action, next) {
    next(action);
    objectBox.userBox.changeBiometricOption(!(store.state.user?.isBiometricEnabled ?? false));
    store.dispatch(
      UserChanged(
        user: store.state.user?.changeBiometricOption(!(store.state.user?.isBiometricEnabled ?? false)),
      ),
    );
  };
}
