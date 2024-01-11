/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/secret_note_model.dart';

SecretNote getSecretNoteByIndex(AppState state, int index) => state.secretNoteList![index];

SecretNote? getSecretNoteById(AppState state, int? secretNoteId) {
  SecretNote? tempSecretNote;
  try {
    tempSecretNote = secretNoteId == null ? null : state.secretNoteList?.singleWhere((element) => element.id == secretNoteId);
  } catch (e) {
    tempSecretNote = null;
  }
  return tempSecretNote;
}

List<SecretNote> getSecretNoteList(AppState state) {
  return state.secretNoteList ?? [];
}
