/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/model/secret_note_model.dart';

class GetAllSecretNotes {}

class CreateSecretNote {
  final String note;

  CreateSecretNote({
    required this.note,
  });
}

class UpdateSecretNote {
  final SecretNote secretNote;

  UpdateSecretNote({
    required this.secretNote,
  });
}

class DeleteSecretNote {
  final int secretNoteId;

  DeleteSecretNote({
    required this.secretNoteId,
  });
}

class SecretNoteListChanged {
  final List<SecretNote> secretNoteList;

  SecretNoteListChanged({
    required this.secretNoteList,
  });
}
