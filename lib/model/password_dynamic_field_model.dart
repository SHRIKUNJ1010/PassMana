/*
* Created by Shrikunj Patel on 1/23/2024.
*/

class PasswordDynamicFieldList {
  List<PasswordDynamicField>? dynamicField;

  PasswordDynamicFieldList({
    this.dynamicField = const [],
  });

  PasswordDynamicFieldList.fromJson(Map<String, dynamic> json) {
    if (json['dynamic_fields'] != null) {
      dynamicField = <PasswordDynamicField>[];
      json['dynamic_fields'].forEach((v) {
        dynamicField?.add(PasswordDynamicField.fromJson(v));
      });
    }
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['dynamic_fields'] = dynamicField;
    return data;
  }
}

class PasswordDynamicField {
  String? title;
  String? value;

  PasswordDynamicField({
    this.title = '',
    this.value = '',
  });

  PasswordDynamicField.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    value = json['value'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title ?? "";
    data['value'] = value ?? "";
    return data;
  }
}
