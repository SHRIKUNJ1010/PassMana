/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';

class SecretNoteBox {
  late final Box<SecretNote> _secretNoteBox;

  SecretNoteBox(Store store) {
    _secretNoteBox = Box<SecretNote>(store);
  }

  addSecretNote({
    String note = '',
  }) async {
    String tempNote = await CryptoUtility.encryptText(note);
    final tempSecretNoteModel = SecretNote(
      note: tempNote,
      createdOn: DateTime.now(),
      lastUpdatedOn: DateTime.now(),
    );
    await _secretNoteBox.putAsync(
      tempSecretNoteModel,
      mode: PutMode.insert,
    );
  }

  updateSecretNote({
    required int id,
    String note = '',
  }) async {
    String tempNote = await CryptoUtility.encryptText(note);
    final tempSecretNoteModel = (await getOneSecretNote(id) ??
            SecretNote(
              id: id,
              createdOn: DateTime.now(),
              lastUpdatedOn: DateTime.now(),
            ))
        .updateSecretNote(
      note: tempNote,
      lastUpdatedOn: DateTime.now(),
    );
    await _secretNoteBox.putAsync(
      tempSecretNoteModel,
      mode: PutMode.update,
    );
  }

  Future<List<SecretNote>> getAllSecretNote() async {
    List<SecretNote> tempSecretNotes = [];

    for (SecretNote element in _secretNoteBox.getAll()) {
      String tempNote = await CryptoUtility.decryptText(element.note);
      tempSecretNotes.add(
        element.updateSecretNote(
          note: tempNote,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempSecretNotes;
  }

  addAllSecretNote(List<SecretNote> tempSecretNotes) async {
    List<SecretNote> temp = [];

    for (SecretNote element in tempSecretNotes) {
      String tempNote = await CryptoUtility.encryptText(element.note);
      temp.add(
        element.updateSecretNote(
          note: tempNote,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    await _secretNoteBox.putManyAsync(temp);
  }

  Future<SecretNote?> getOneSecretNote(int secretNoteId) async {
    SecretNote tempSecretNoteValue = _secretNoteBox.get(secretNoteId) ??
        SecretNote(
          id: secretNoteId,
          createdOn: DateTime.now(),
          lastUpdatedOn: DateTime.now(),
        );
    String tempNote = await CryptoUtility.decryptText(tempSecretNoteValue.note);
    return tempSecretNoteValue.updateSecretNote(
      note: tempNote,
      lastUpdatedOn: tempSecretNoteValue.lastUpdatedOn,
    );
  }

  deleteSecretNote(int secretNoteId) async {
    await _secretNoteBox.removeAsync(secretNoteId);
  }
}
