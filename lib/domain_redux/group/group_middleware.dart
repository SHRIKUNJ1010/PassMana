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

List<Middleware<AppState>> createGroupMiddleware() {
  return [
    TypedMiddleware<AppState, CreateGroup>(_createGroup()).call,
    TypedMiddleware<AppState, UpdateGroup>(_updateGroup()).call,
    TypedMiddleware<AppState, DeleteGroup>(_deleteGroup()).call,
    TypedMiddleware<AppState, GetAllGroups>(_getAllGroups()).call,
  ];
}

void Function(Store<AppState> store, CreateGroup action, NextDispatcher next) _createGroup() {
  return (store, action, next) async {
    next(action);
    //add group in object box database
    await objectBox.groupBox.addGroup(
      groupName: action.groupName,
      description: action.description,
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

void Function(Store<AppState> store, UpdateGroup action, NextDispatcher next) _updateGroup() {
  return (store, action, next) async {
    next(action);
    //update group in object box database
    await objectBox.groupBox.updateGroup(
      id: action.id,
      groupName: action.groupName,
      description: action.description,
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

void Function(Store<AppState> store, DeleteGroup action, NextDispatcher next) _deleteGroup() {
  return (store, action, next) async {
    next(action);
    //delete group from object box database
    await objectBox.groupBox.deleteGroup(action.groupId);
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

void Function(Store<AppState> store, GetAllGroups action, NextDispatcher next) _getAllGroups() {
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
