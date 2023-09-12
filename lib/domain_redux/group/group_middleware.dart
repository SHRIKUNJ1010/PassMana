/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/group_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createGroupMiddleware() {
  return [
    TypedMiddleware<AppState, CreateGroup>(_createGroup()),
    TypedMiddleware<AppState, UpdateGroup>(_updateGroup()),
    TypedMiddleware<AppState, DeleteGroup>(_deleteGroup()),
    TypedMiddleware<AppState, GetAllGroups>(_getAllGroups()),
  ];
}

void Function(Store<AppState> store, CreateGroup action, NextDispatcher next) _createGroup() {
  return (store, action, next) {
    next(action);
    objectBox.groupBox.addGroup(
      groupName: action.groupName,
      description: action.description,
    );
    List<Group> groups = objectBox.groupBox.getAllGroups();
    store.dispatch(GroupListChanged(groupList: groups));
  };
}

void Function(Store<AppState> store, UpdateGroup action, NextDispatcher next) _updateGroup() {
  return (store, action, next) {
    next(action);
    objectBox.groupBox.updateGroup(group: action.group);
    List<Group> groups = objectBox.groupBox.getAllGroups();
    store.dispatch(GroupListChanged(groupList: groups));
  };
}

void Function(Store<AppState> store, DeleteGroup action, NextDispatcher next) _deleteGroup() {
  return (store, action, next) {
    next(action);
    objectBox.groupBox.deleteGroup(action.groupId);
    List<Group> groups = objectBox.groupBox.getAllGroups();
    store.dispatch(GroupListChanged(groupList: groups));
  };
}

void Function(Store<AppState> store, GetAllGroups action, NextDispatcher next) _getAllGroups() {
  return (store, action, next) {
    next(action);
    List<Group> groups = objectBox.groupBox.getAllGroups();
    store.dispatch(GroupListChanged(groupList: groups));
  };
}
