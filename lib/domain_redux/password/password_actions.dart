/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';

class GetAllPasswords {}

class CreatePassword {
  final String title;
  final String subTitle;
  final String websiteUrl;
  final String userName;
  final String password;
  final String note;
  final String dynamicDataField;
  final Group? targetGroup;

  CreatePassword({
    required this.title,
    required this.subTitle,
    required this.websiteUrl,
    required this.userName,
    required this.password,
    required this.note,
    required this.dynamicDataField,
    this.targetGroup,
  });
}

class UpdatePassword {
  final Password password;

  UpdatePassword({
    required this.password,
  });
}

class DeletePassword {
  final int passwordId;

  DeletePassword({
    required this.passwordId,
  });
}

class PasswordListChanged {
  final List<Password> passwordList;
  final List<Password> recentlyAddedPasswordList;

  PasswordListChanged({
    required this.passwordList,
    required this.recentlyAddedPasswordList,
  });
}

class AssignPasswordToGroup {
  final Password password;
  final Group group;

  AssignPasswordToGroup({
    required this.password,
    required this.group,
  });
}
