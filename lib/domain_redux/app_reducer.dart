/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/domain_redux/app_actions.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_reducer.dart';
import 'package:passmana/domain_redux/group/group_reducer.dart';
import 'package:passmana/domain_redux/password/password_reducer.dart';
import 'package:passmana/domain_redux/user/user_reducer.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  ...userReducers,
  ...passwordReducers,
  ...groupReducers,
  ...filterSearchReducers,
  localeChangedReducer,
]);

//locale change reducer alone without list and define reducers particularly for this
// as mentioned below unless they are of same category don't use list of reducers here
final localeChangedReducer = TypedReducer<AppState, LocaleChanged>(_onLocaleChanged);

AppState _onLocaleChanged(AppState state, LocaleChanged action) {
  return state.copyWith(locale: action.locale);
}
