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
  final int id;
  final String note;

  UpdateSecretNote({
    required this.id,
    required this.note,
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
