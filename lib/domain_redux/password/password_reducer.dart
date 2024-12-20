/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:redux/redux.dart';

final passwordReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, PasswordListChanged>(_onPasswordListChanged).call,
];

AppState _onPasswordListChanged(AppState state, PasswordListChanged action) {
  return state.copyWith(
    passwordList: action.passwordList,
    recentlyAddedPasswordList: action.recentlyAddedPasswordList,
  );
}
