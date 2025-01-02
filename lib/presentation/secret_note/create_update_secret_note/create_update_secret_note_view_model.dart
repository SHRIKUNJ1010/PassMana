/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_selector.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdateSecretNoteViewModel {
  final SecretNote? secretNote;
  final Function({
    required String note,
  }) createSecretNote;

  final Function({
    required String note,
  }) updateSecretNote;
  final Function deleteSecretNote;
  final Function onBackPress;

  CreateUpdateSecretNoteViewModel({
    this.secretNote,
    required this.createSecretNote,
    required this.updateSecretNote,
    required this.deleteSecretNote,
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
        router.pop();
      },
      updateSecretNote: ({
        required String note,
      }) {
        store.dispatch(
          UpdateSecretNote(
            id: id ?? 0,
            note: note,
          ),
        );
        router.pop();
      },
      deleteSecretNote: () async {
        bool hasConfirmed = await Utility.deleteConfirmationDialog();
        if (hasConfirmed) {
          store.dispatch(DeleteSecretNote(secretNoteId: id ?? 0));
          router.go(AppRoutes.secretNoteList);
        }
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
