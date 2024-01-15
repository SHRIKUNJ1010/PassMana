/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_reducer.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_reducer.dart';
import 'package:passmana/domain_redux/group/group_reducer.dart';
import 'package:passmana/domain_redux/password/password_reducer.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_reducer.dart';
import 'package:passmana/domain_redux/user/user_reducer.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  ...userReducers,
  ...passwordReducers,
  ...groupReducers,
  ...cardReducers,
  ...secretNoteReducers,
  ...filterSearchReducers,
]);
