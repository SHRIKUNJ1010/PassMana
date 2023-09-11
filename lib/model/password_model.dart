/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';

@Entity()
class Password {
  @Id()
  int id;
  String title;
  String subTitle;
  String userName;
  String password;
  String note;
  final group = ToOne<Group>();

  Password({
    this.id = 0,
    this.title = '',
    this.subTitle = '',
    this.userName = '',
    this.password = '',
    this.note = '',
  });

  updatePassword({
    String? title,
    String? subTitle,
    String? userName,
    String? password,
    String? note,
  }) {
    this.title = title ?? this.title;
    this.subTitle = subTitle ?? this.subTitle;
    this.userName = userName ?? this.userName;
    this.password = password ?? this.password;
    this.note = note ?? this.note;
  }
}
