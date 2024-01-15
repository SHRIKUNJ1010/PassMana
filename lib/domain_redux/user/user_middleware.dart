/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/utility/method_channel_utility/biometric_verification_channel.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUserMiddleware() {
  return [
    TypedMiddleware<AppState, CreateUser>(_createUser()),
    TypedMiddleware<AppState, UpdatePin>(_updatePin()),
    TypedMiddleware<AppState, VerifyUserPin>(_verifyUserPin()),
    TypedMiddleware<AppState, VerifyUserBiometric>(_verifyUserBiometric()),
    TypedMiddleware<AppState, SwitchBiometricOption>(_switchBiometricOption()),
    TypedMiddleware<AppState, SwitchAutoFillOption>(_switchAutoFillOption()),
    TypedMiddleware<AppState, ChangeLanguage>(_changeLanguage()),
    TypedMiddleware<AppState, LoadUser>(_loadUser()),
  ];
}

void Function(Store<AppState> store, LoadUser action, NextDispatcher next) _loadUser() {
  return (store, action, next) {
    next(action);
    //get user from database
    User user = objectBox.userBox.getUser() ?? User();
    //change the user in state
    store.dispatch(
      UserChanged(
        user: user,
      ),
    );
  };
}

void Function(Store<AppState> store, CreateUser action, NextDispatcher next) _createUser() {
  return (store, action, next) {
    next(action);
    //for create user call either of change create pin
    //method will create user if does not exist in object box database
    //for remaining parameter change its value
    objectBox.userBox.changeCreatePin(action.pin);
    //change latest value for user in state
    store.dispatch(LoadUser());
  };
}

void Function(Store<AppState> store, UpdatePin action, NextDispatcher next) _updatePin() {
  return (store, action, next) {
    next(action);
    //change pin of user in object box database and if user does not exist then
    // it will create new user and update pin value
    objectBox.userBox.changeCreatePin(action.pin);
    //change latest value for user in state
    store.dispatch(LoadUser());
  };
}

void Function(Store<AppState> store, VerifyUserPin action, NextDispatcher next) _verifyUserPin() {
  return (store, action, next) {
    next(action);
    if (objectBox.userBox.getUser()?.pin == action.pin) {
      action.onVerified.call();
    } else {
      action.onNotVerified.call();
    }
  };
}

void Function(Store<AppState> store, VerifyUserBiometric action, NextDispatcher next) _verifyUserBiometric() {
  return (store, action, next) {
    next(action);
    BiometricsChannel.verifyBiometric().then(
      (value) {
        if (value) {
          action.onVerified.call();
        } else {
          action.onNotVerified.call();
        }
      },
    );
  };
}

void Function(Store<AppState> store, ChangeLanguage action, NextDispatcher next) _changeLanguage() {
  return (store, action, next) {
    next(action);
    //get new biometric value
    String localeNewValue = action.languageValue;
    // get new user value
    //final User changedUser = store.state.user?.changeLanguage(localeNewValue) ?? User();
    //change the value of biometric option for user
    objectBox.userBox.changeLanguage(localeNewValue);
    //change latest value for user in state
    store.dispatch(LoadUser());
  };
}

void Function(Store<AppState> store, SwitchAutoFillOption action, NextDispatcher next) _switchAutoFillOption() {
  return (store, action, next) {
    next(action);
    //get new biometric value
    bool changedOption = !(store.state.user?.isAutofillEnabled ?? false);
    // get new user value
    //final User changedUser = store.state.user?.changeAutofillOption(changedOption) ?? User();
    //change the value of biometric option for user
    objectBox.userBox.changeAutofillOption(changedOption);
    //change latest value for user in state
    store.dispatch(LoadUser());
  };
}

void Function(Store<AppState> store, SwitchBiometricOption action, NextDispatcher next) _switchBiometricOption() {
  return (store, action, next) {
    next(action);
    //get new biometric value
    bool changedOption = !(store.state.user?.isBiometricEnabled ?? false);
    // get new user value
    //final User changedUser = store.state.user?.changeBiometricOption(changedOption) ?? User();
    //change the value of biometric option for user
    objectBox.userBox.changeBiometricOption(changedOption);
    //change latest value for user in state
    store.dispatch(LoadUser());
  };
}
