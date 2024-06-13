/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class SecretNote {
  //TODO: add title parameter for secret note and adjust secret note screens accordingly
  @Id(assignable: true)
  int id;
  String note;
  @Property(type: PropertyType.date)
  DateTime createdOn;
  @Property(type: PropertyType.date)
  DateTime lastUpdatedOn;

  SecretNote({
    this.id = 0,
    this.note = '',
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  SecretNote updateSecretNote({
    String? note,
    required DateTime lastUpdatedOn,
  }) {
    return SecretNote(
      id: id,
      note: note ?? this.note,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }

  factory SecretNote.fromJson(Map<String, dynamic> json) => SecretNote(
        id: json['id'],
        note: json['note'],
        createdOn: DateTime.tryParse(json['created_on']) ?? DateTime.now(),
        lastUpdatedOn: DateTime.tryParse(json['last_updated_on']) ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['created_on'] = createdOn.toString();
    data['last_updated_on'] = lastUpdatedOn.toString();
    return data;
  }
}
