/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class SecretNote {
  @Id()
  int id;
  String note;

  SecretNote({
    this.id = 0,
    this.note = '',
  });

  SecretNote updateSecretNote({
    String? note,
  }) {
    return SecretNote(
      id: id,
      note: note ?? this.note,
    );
  }
}