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
    //for create user call either of change create master password or change create pin
    //both method will create user if does not exist in object box database
    objectBox.userBox.changeCreateMasterPassword(action.masterPassword);
    //for remaining parameter change its value
    objectBox.userBox.changeCreatePin(action.pin);
    //change latest value for user in state
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
    //change pin of user in object box database and if user does not exist then
    // it will create new user and update pin value
    objectBox.userBox.changeCreatePin(action.pin);
    //change latest value for user in state
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
    //change master password in object box database and if user does not exist then
    // it will create new user and update master password value
    objectBox.userBox.changeCreateMasterPassword(action.masterPassword);
    //change latest value for user in state
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
    //change the value of biometric option for user
    objectBox.userBox.changeBiometricOption(!(store.state.user?.isBiometricEnabled ?? false));
    //change latest value for user in state
    store.dispatch(
      UserChanged(
        user: store.state.user?.changeBiometricOption(!(store.state.user?.isBiometricEnabled ?? false)),
      ),
    );
  };
}
