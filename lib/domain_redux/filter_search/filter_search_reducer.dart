/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_actions.dart';
import 'package:redux/redux.dart';

final filterSearchReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, SelectedGroupForFilterListChanged>(_onSelectedGroupForFilterListChanged).call,
  TypedReducer<AppState, SearchKeywordChanged>(_onSearchKeywordChanged).call,
];

AppState _onSelectedGroupForFilterListChanged(AppState state, SelectedGroupForFilterListChanged action) {
  return state.copyWith(selectedGroupsForFilterList: action.selectedGroupsForFilterList);
}

AppState _onSearchKeywordChanged(AppState state, SearchKeywordChanged action) {
  return state.copyWith(
    searchKeyword: action.searchKeyword,
    searchedPasswordList: action.searchedPasswordList,
  );
}
