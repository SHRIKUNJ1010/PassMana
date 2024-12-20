/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/data_object_box/import_and_export_database/import_export_database.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/utility/file_utility/file_utility.dart';
import 'package:passmana/utility/method_channel_utility/biometric_verification_channel.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUserMiddleware() {
  return [
    TypedMiddleware<AppState, CreateUser>(_createUser()).call,
    TypedMiddleware<AppState, UpdatePin>(_updatePin()).call,
    TypedMiddleware<AppState, VerifyUserPin>(_verifyUserPin()).call,
    TypedMiddleware<AppState, VerifyUserBiometric>(_verifyUserBiometric()).call,
    TypedMiddleware<AppState, SwitchBiometricOption>(_switchBiometricOption()).call,
    TypedMiddleware<AppState, SwitchAutoFillOption>(_switchAutoFillOption()).call,
    TypedMiddleware<AppState, ChangeLanguage>(_changeLanguage()).call,
    TypedMiddleware<AppState, LoadUser>(_loadUser()).call,
    TypedMiddleware<AppState, ImportDataToDatabase>(_importDataToDatabase()).call,
    TypedMiddleware<AppState, ExportDataFromDatabase>(_exportDataFromDatabase()).call,
  ];
}

Future<void> Function(Store<AppState> store, ImportDataToDatabase action, NextDispatcher next) _importDataToDatabase() {
  return (store, action, next) async {
    next(action);
    String? importedFilePath = await FileUtility.pickFileFromStorage();
    if (importedFilePath == null) return;
    //Import Data to Database
    await ImportExportDatabase.import(importedFilePath);
    store.dispatch(GetAllPasswords());
    store.dispatch(GetAllCards());
    store.dispatch(GetAllGroups());
    store.dispatch(GetAllSecretNotes());
  };
}

Future<void> Function(Store<AppState> store, ExportDataFromDatabase action, NextDispatcher next) _exportDataFromDatabase() {
  return (store, action, next) async {
    next(action);
    String exportedFilePath = await ImportExportDatabase.export();
    if (exportedFilePath.isNotEmpty) {
      Utility.exportedDbFileLocationDialog(exportedFilePath);
    }
  };
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
