/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';

@Entity()
class Password {
  @Id(assignable: true)
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

  factory Password.fromJson(Map<String, dynamic> json) => Password(
        id: json['id'],
        title: json['title'],
        subTitle: json['sub_title'],
        websiteUrl: json['website_url'],
        userName: json['user_name'],
        password: json['password'],
        note: json['note'],
        dynamicDataField: json['dynamic_data_field'],
        createdOn: DateTime.tryParse(json['created_on']) ?? DateTime.now(),
        lastUpdatedOn: DateTime.tryParse(json['last_updated_on']) ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['website_url'] = websiteUrl;
    data['user_name'] = userName;
    data['password'] = password;
    data['note'] = note;
    data['dynamic_data_field'] = dynamicDataField;
    data['created_on'] = createdOn.toString();
    data['last_updated_on'] = lastUpdatedOn.toString();
    data['target_group'] = group.target?.id;
    return data;
  }
}
