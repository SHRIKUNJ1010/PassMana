/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/object_box/password_box.dart';

@Entity()
class Group {
  @Id()
  int id;
  String groupName;
  String description;

  @Backlink('group')
  final passwords = ToMany<Password>;

  Group({
    this.id = 0,
    this.groupName = '',
    this.description = '',
  });
}
