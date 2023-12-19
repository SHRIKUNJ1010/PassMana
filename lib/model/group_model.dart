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

  //relationship backlink from password's group
  @Backlink("group")
  final passwords = ToMany<Password>();

  Group({
    this.id = 0,
    this.groupName = '',
    this.description = '',
  });

  Group updateGroupInfo({
    String? groupName,
    String? description,
  }) {
    return Group(
      id: id,
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
    );
  }
}
