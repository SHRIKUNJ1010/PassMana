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
    //add password in object box database
    objectBox.passwordBox.addPassword(
      title: action.title,
      subTitle: action.subTitle,
      userName: action.userName,
      password: action.password,
      note: action.note,
    );
    //get all latest passwords
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
  };
}

void Function(Store<AppState> store, UpdatePassword action, NextDispatcher next) _updatePassword() {
  return (store, action, next) {
    next(action);
    //update password in object box database
    objectBox.passwordBox.updatePassword(password: action.password);
    //get all latest passwords
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
  };
}

void Function(Store<AppState> store, DeletePassword action, NextDispatcher next) _deletePassword() {
  return (store, action, next) {
    next(action);
    //delete password from object box database
    objectBox.passwordBox.deletePassword(action.passwordId);
    //get all latest passwords
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
  };
}

void Function(Store<AppState> store, GetAllPasswords action, NextDispatcher next) _getAllPasswords() {
  return (store, action, next) {
    next(action);
    //get all latest passwords
    List<Password> passwords = objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
  };
}
