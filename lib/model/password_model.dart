/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';

@Entity()
class Password {
  @Id()
  int id;

  //data1
  String title;
  String subTitle;

  //data2
  String websiteUrl;
  String userName;
  String password;

  //data3
  String note;

  //data4
  String dynamicDataField;

  //data5
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
    this.dynamicDataField = '{}',
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
    String? dynamicDataField,
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
      dynamicDataField: dynamicDataField ?? this.dynamicDataField,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }
}
