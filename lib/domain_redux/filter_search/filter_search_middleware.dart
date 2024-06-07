/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createFilterSearchMiddleware() {
  return [
    TypedMiddleware<AppState, InitializeFilter>(_initializeFilter()),
    TypedMiddleware<AppState, ChangeSelectionOfGroup>(_changeSelectionGroup()),
    TypedMiddleware<AppState, ChangeKeyword>(_changeKeyword()),
  ];
}

void Function(Store<AppState> store, InitializeFilter action, NextDispatcher next) _initializeFilter() {
  return (store, action, next) {
    next(action);
    //set every available group as selected in filter
    List<Map<Group, bool>> tempList = [];
    if (store.state.groupList != null) {
      store.state.groupList?.forEach((element) {
        tempList.add({element: true});
      });
    }

    List<Password> tempPasswordList = objectBox.passwordBox.getAllPasswordsWithRecentlyCreatedFirst();
    //change state for filter group list
    store.dispatch(SelectedGroupForFilterListChanged(selectedGroupsForFilterList: tempList));
    //change search keyword as blank
    store.dispatch(
      SearchKeywordChanged(
        searchKeyword: '',
        searchedPasswordList: tempPasswordList,
      ),
    );
  };
}

void Function(Store<AppState> store, ChangeSelectionOfGroup action, NextDispatcher next) _changeSelectionGroup() {
  return (store, action, next) {
    next(action);
    //currently available selected group list
    List<Map<Group, bool>>? tempList = store.state.selectedGroupsForFilterList;
    List<Map<Group, bool>> tempList2 = [];

    //group value which is getting selected/deselected
    Group? tempGroup = store.state.groupList?.singleWhere((element) => element.id == action.groupId);
    //group value with selected/ deselected value and key
    Map<Group, bool>? tempData = store.state.selectedGroupsForFilterList?.singleWhere(
      (element) =>
          (element.keys.singleWhere(
            (element) => element.id == action.groupId,
          )) ==
          (tempGroup),
    );
    //is group selected or not
    bool tempValue = tempData != null ? tempData[tempGroup] ?? false : false;
    //change group selection
    if (tempData != null && tempGroup != null) {
      tempData[tempGroup] = !tempValue;
    }
    //replace old key value pair with new key value pair in filtered group list
    if (tempList != null) {
      for (var element in tempList) {
        if (element.keys.contains(tempGroup)) {
          if (tempData != null) tempList2.add(tempData);
        } else {
          tempList2.add(element);
        }
      }
    }
    //change selected group for filter list in state by using reducer
    store.dispatch(SelectedGroupForFilterListChanged(selectedGroupsForFilterList: tempList2));
  };
}

void Function(Store<AppState> store, ChangeKeyword action, NextDispatcher next) _changeKeyword() {
  return (store, action, next) {
    next(action);
    List<Password> tempList = objectBox.passwordBox.getPasswordBasedOnKeyword(action.searchKeyword);

    //change search keyword in state
    store.dispatch(
      SearchKeywordChanged(
        searchKeyword: action.searchKeyword,
        searchedPasswordList: tempList,
      ),
    );
  };
}
