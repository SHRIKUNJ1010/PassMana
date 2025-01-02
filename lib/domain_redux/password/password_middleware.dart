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
    TypedMiddleware<AppState, CreatePassword>(_createPassword()).call,
    TypedMiddleware<AppState, UpdatePassword>(_updatePassword()).call,
    TypedMiddleware<AppState, DeletePassword>(_deletePassword()).call,
    TypedMiddleware<AppState, GetAllPasswords>(_getAllPasswords()).call,
    TypedMiddleware<AppState, AssignPasswordToGroup>(_assignPasswordToGroup()).call,
  ];
}

void Function(Store<AppState> store, CreatePassword action, NextDispatcher next) _createPassword() {
  return (store, action, next) async {
    next(action);
    //add password in object box database
    await objectBox.passwordBox.addPassword(
      title: action.title,
      subTitle: action.subTitle,
      websiteUrl: action.websiteUrl,
      userName: action.userName,
      password: action.password,
      note: action.note,
      dynamicDataField: action.dynamicDataField,
      targetGroup: action.targetGroup,
    );
    //get all latest passwords
    List<Password> passwords = await objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = await objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
    //get all latest groups
    List<Group> groups = await objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = await objectBox.groupBox.getPopularGroups();
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
  return (store, action, next) async {
    next(action);
    //update password in object box database
    await objectBox.passwordBox.updatePassword(
      id: action.id,
      title: action.title,
      subTitle: action.subTitle,
      websiteUrl: action.websiteUrl,
      userName: action.userName,
      password: action.password,
      note: action.note,
      dynamicDataField: action.dynamicDataField,
      targetGroup: action.targetGroup,
    );
    //get all latest passwords
    List<Password> passwords = await objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = await objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
    //get all latest groups
    List<Group> groups = await objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = await objectBox.groupBox.getPopularGroups();
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
  return (store, action, next) async {
    next(action);
    //delete password from object box database
    await objectBox.passwordBox.deletePassword(action.passwordId);
    //get all latest passwords
    List<Password> passwords = await objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = await objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
    //get all latest groups
    List<Group> groups = await objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = await objectBox.groupBox.getPopularGroups();
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
  return (store, action, next) async {
    next(action);
    //get all latest passwords
    List<Password> passwords = await objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = await objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
    //get all latest groups
    List<Group> groups = await objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = await objectBox.groupBox.getPopularGroups();
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
  return (store, action, next) async {
    next(action);
    //assign password to group
    objectBox.passwordBox.assignPasswordToGroup(action.password, action.group);
    //get all latest passwords
    List<Password> passwords = await objectBox.passwordBox.getAllPasswords();
    //get recently added passwords
    List<Password> recentlyAddedPasswords = await objectBox.passwordBox.getRecentlyAddedPasswords();
    //change the list of passwords in state
    store.dispatch(
      PasswordListChanged(
        passwordList: passwords,
        recentlyAddedPasswordList: recentlyAddedPasswords,
      ),
    );
    //get all latest groups
    List<Group> groups = await objectBox.groupBox.getAllGroups();
    //get popular groups
    List<Group> popularGroups = await objectBox.groupBox.getPopularGroups();
    //change the list of groups in state
    store.dispatch(
      GroupListChanged(
        groupList: groups,
        popularGroupList: popularGroups,
      ),
    );
  };
}
