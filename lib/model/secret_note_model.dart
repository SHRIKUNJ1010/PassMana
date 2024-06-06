/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class SecretNote {
  @Id()
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
        createdOn: json['created_on'],
        lastUpdatedOn: json['last_updated_on'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['created_on'] = createdOn;
    data['last_updated_on'] = lastUpdatedOn;
    return data;
  }
}
