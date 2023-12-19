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
    //add group in object box database
    objectBox.groupBox.addGroup(
      groupName: action.groupName,
      description: action.description,
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

void Function(Store<AppState> store, UpdateGroup action, NextDispatcher next) _updateGroup() {
  return (store, action, next) {
    next(action);
    //update group in object box database
    objectBox.groupBox.updateGroup(group: action.group);
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

void Function(Store<AppState> store, DeleteGroup action, NextDispatcher next) _deleteGroup() {
  return (store, action, next) {
    next(action);
    //delete group from object box database
    objectBox.groupBox.deleteGroup(action.groupId);
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

void Function(Store<AppState> store, GetAllGroups action, NextDispatcher next) _getAllGroups() {
  return (store, action, next) {
    next(action);
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
