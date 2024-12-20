/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:redux/redux.dart';

final userReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, UserChanged>(_onUserChanged).call,
];

AppState _onUserChanged(AppState state, UserChanged action) {
  return state.copyWith(user: action.user);
}
