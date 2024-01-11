/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/password_model.dart';

@Entity()
class Group {
  @Id()
  int id;
  String groupName;
  String description;
  @Property(type: PropertyType.date)
  DateTime createdOn;
  @Property(type: PropertyType.date)
  DateTime lastUpdatedOn;

  //relationship backlink from password's group
  @Backlink("group")
  final passwords = ToMany<Password>();

  Group({
    this.id = 0,
    this.groupName = '',
    this.description = '',
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  Group updateGroupInfo({
    String? groupName,
    String? description,
    required DateTime lastUpdatedOn,
  }) {
    return Group(
      id: id,
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }
}
