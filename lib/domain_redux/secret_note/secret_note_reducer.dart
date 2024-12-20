/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:redux/redux.dart';

final secretNoteReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, SecretNoteListChanged>(_onSecretNoteListChanged).call,
];

AppState _onSecretNoteListChanged(AppState state, SecretNoteListChanged action) {
  return state.copyWith(secretNoteList: action.secretNoteList);
}
