/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_selector.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class CreateUpdateSecretNoteViewModel {
  final SecretNote? secretNote;
  final Function({
    required String note,
  }) createSecretNote;

  final Function({
    required String note,
  }) updateSecretNote;
  final Function onBackPress;

  CreateUpdateSecretNoteViewModel({
    this.secretNote,
    required this.createSecretNote,
    required this.updateSecretNote,
    required this.onBackPress,
  });

  static CreateUpdateSecretNoteViewModel fromStore(Store<AppState> store, int? id) {
    return CreateUpdateSecretNoteViewModel(
      secretNote: getSecretNoteById(store.state, id),
      createSecretNote: ({
        required String note,
      }) {
        store.dispatch(
          CreateSecretNote(
            note: note,
          ),
        );
      },
      updateSecretNote: ({
        required String note,
      }) {
        store.dispatch(
          UpdateSecretNote(
            secretNote: getSecretNoteById(store.state, id)?.updateSecretNote(
                  note: note,
                  lastUpdatedOn: DateTime.now(),
                ) ??
                SecretNote(
                  createdOn: DateTime.now(),
                  lastUpdatedOn: DateTime.now(),
                ),
          ),
        );
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
