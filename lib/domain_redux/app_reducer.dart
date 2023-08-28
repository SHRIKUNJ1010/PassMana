/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_reducer.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  ...userReducers,
]);
