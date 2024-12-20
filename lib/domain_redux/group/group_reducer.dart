/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:redux/redux.dart';

final groupReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, GroupListChanged>(_onGroupListChanged).call,
];

AppState _onGroupListChanged(AppState state, GroupListChanged action) {
  return state.copyWith(
    groupList: action.groupList,
    popularGroupList: action.popularGroupList,
  );
}
