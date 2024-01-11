/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPasswordMiddleware() {
  return [
    TypedMiddleware<AppState, CreatePassword>(_createPassword()),
    TypedMiddleware<AppState, UpdatePassword>(_updatePassword()),
    TypedMiddleware<AppState, DeletePassword>(_deletePassword()),
    TypedMiddleware<AppState, GetAllPasswords>(_getAllPasswords()),
    TypedMiddleware<AppState, AssignPasswordToGroup>(_assignPasswordToGroup()),
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
      targetGroup: action.targetGroup,
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
    //get all latest groups
    List<Group> groups = objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
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
    //get all latest groups
    List<Group> groups = objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
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
    //get all latest groups
    List<Group> groups = objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
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
    //get all latest groups
    List<Group> groups = objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
      ),
    );
  };
}

void Function(Store<AppState> store, AssignPasswordToGroup action, NextDispatcher next) _assignPasswordToGroup() {
  return (store, action, next) {
    next(action);
    //assign password to group
    objectBox.passwordBox.assignPasswordToGroup(action.password, action.group);
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
    //get all latest groups
    List<Group> groups = objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
      ),
    );
  };
}
