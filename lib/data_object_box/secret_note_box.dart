/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/secret_note_model.dart';

class SecretNoteBox {
  late final Box<SecretNote> _secretNoteBox;

  SecretNoteBox(Store store) {
    _secretNoteBox = Box<SecretNote>(store);
  }

  addSecretNote({
    String note = '',
  }) {
    _secretNoteBox.put(
      SecretNote(
        note: note,
        createdOn: DateTime.now(),
        lastUpdatedOn: DateTime.now(),
      ),
      mode: PutMode.insert,
    );
  }

  updateSecretNote({
    required SecretNote secretNote,
  }) {
    _secretNoteBox.put(
      secretNote,
      mode: PutMode.update,
    );
  }

  List<SecretNote> getAllSecretNote() {
    return _secretNoteBox.getAll();
  }

  SecretNote? getOneSecretNote(int secretNoteId) {
    return _secretNoteBox.get(secretNoteId);
  }

  deleteSecretNote(int secretNoteId) {
    _secretNoteBox.remove(secretNoteId);
  }
}
