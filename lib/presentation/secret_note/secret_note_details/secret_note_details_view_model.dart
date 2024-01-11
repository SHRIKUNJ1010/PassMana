/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_selector.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class SecretNoteDetailsViewModel {
  final SecretNote secretNote;
  final Function onBackPress;

  SecretNoteDetailsViewModel({
    required this.secretNote,
    required this.onBackPress,
  });

  static SecretNoteDetailsViewModel fromStore(Store<AppState> store, int id) {
    return SecretNoteDetailsViewModel(
      secretNote: getSecretNoteById(store.state, id) ??
          SecretNote(
            createdOn: DateTime.now(),
            lastUpdatedOn: DateTime.now(),
          ),
      onBackPress: () {
        router.pop();
      },
    );
  }
}
