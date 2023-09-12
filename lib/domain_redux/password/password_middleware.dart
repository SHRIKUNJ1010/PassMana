/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPasswordMiddleware() {
  return [
    TypedMiddleware<AppState, CreatePassword>(_createPassword()),
    TypedMiddleware<AppState, UpdatePassword>(_updatePassword()),
    TypedMiddleware<AppState, DeletePassword>(_deletePassword()),
    TypedMiddleware<AppState, GetAllPasswords>(_getAllPasswords()),
  ];
}

void Function(Store<AppState> store, CreatePassword action, NextDispatcher next) _createPassword() {
  return (store, action, next) {
    next(action);
    objectBox.passwordBox.addPassword(
      title: action.title,
      subTitle: action.subTitle,
      userName: action.userName,
      password: action.password,
      note: action.note,
    );
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    store.dispatch(PasswordListChanged(passwordList: passwords));
  };
}

void Function(Store<AppState> store, UpdatePassword action, NextDispatcher next) _updatePassword() {
  return (store, action, next) {
    next(action);
    objectBox.passwordBox.updatePassword(password: action.password);
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    store.dispatch(PasswordListChanged(passwordList: passwords));
  };
}

void Function(Store<AppState> store, DeletePassword action, NextDispatcher next) _deletePassword() {
  return (store, action, next) {
    next(action);
    objectBox.passwordBox.deletePassword(action.passwordId);
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    store.dispatch(PasswordListChanged(passwordList: passwords));
  };
}

void Function(Store<AppState> store, GetAllPasswords action, NextDispatcher next) _getAllPasswords() {
  return (store, action, next) {
    next(action);
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    store.dispatch(PasswordListChanged(passwordList: passwords));
  };
}
