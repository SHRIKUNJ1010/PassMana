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
  @Property(type: PropertyType.date)
  DateTime createdDate;
  final group = ToOne<Group>();

  Password({
    this.id = 0,
    this.title = '',
    this.subTitle = '',
    this.userName = '',
    this.password = '',
    this.note = '',
    required this.createdDate,
  });

  Password updatePassword({
    String? title,
    String? subTitle,
    String? userName,
    String? password,
    String? note,
  }) {
    return Password(
      id: id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      note: note ?? this.note,
      createdDate: createdDate,
    );
  }
}
