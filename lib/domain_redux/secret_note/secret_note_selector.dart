/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/secret_note_model.dart';

SecretNote getSecretNoteByIndex(AppState state, int index) => state.secretNoteList![index];

SecretNote? getSecretNoteById(AppState state, int? secretNoteId) => state.secretNoteList?.singleWhere((element) => element.id == secretNoteId);

List<SecretNote> getSecretNoteList(AppState state) {
  return state.secretNoteList ?? [];
}