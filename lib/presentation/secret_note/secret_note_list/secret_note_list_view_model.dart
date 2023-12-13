/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_selector.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:redux/redux.dart';

class SecretNoteListViewModel {
  final List<SecretNote> secretNoteList;

  SecretNoteListViewModel({required this.secretNoteList});

  static SecretNoteListViewModel fromStore(Store<AppState> store) {
    return SecretNoteListViewModel(
      secretNoteList: getSecretNoteList(store.state),
    );
  }
}