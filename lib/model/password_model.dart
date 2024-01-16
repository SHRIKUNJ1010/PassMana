/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';

@Entity()
class Password {
  @Id()
  int id;
  //
  String title;
  String subTitle;
  //
  String websiteUrl;
  String userName;
  String password;
  //
  String note;
  //
  @Property(type: PropertyType.date)
  DateTime createdOn;
  @Property(type: PropertyType.date)
  DateTime lastUpdatedOn;

  final group = ToOne<Group>();

  Password({
    this.id = 0,
    this.title = '',
    this.subTitle = '',
    this.websiteUrl = '',
    this.userName = '',
    this.password = '',
    this.note = '',
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  Password updatePassword({
    String? title,
    String? subTitle,
    String? websiteUrl,
    String? userName,
    String? password,
    String? note,
    required DateTime lastUpdatedOn,
  }) {
    return Password(
      id: id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      note: note ?? this.note,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }
}
