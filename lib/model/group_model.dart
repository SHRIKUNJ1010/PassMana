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

  @Backlink('group')
  final passwords = ToMany<Password>();

  Group({
    this.id = 0,
    this.groupName = '',
    this.description = '',
  });

  updateGroupInfo({
    String? groupName,
    String? description,
  }) {
    this.groupName = groupName ?? this.groupName;
    this.description = description ?? this.description;
  }
}
