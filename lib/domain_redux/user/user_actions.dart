/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/model/user_model.dart';

class CreateUser {
  final String pin;

  CreateUser({
    required this.pin,
  });
}

class UpdatePin {
  final String pin;

  UpdatePin({
    required this.pin,
  });
}

class UserChanged {
  final User user;

  UserChanged({
    required this.user,
  });
}

class LoadUser {}

class SwitchBiometricOption {}

class SwitchAutoFillOption {}

class ImportDataToDatabase {}

class ExportDataFromDatabase {}

class ChangeLanguage {
  String languageValue;

  ChangeLanguage({
    required this.languageValue,
  });
}

class VerifyUserPin {
  final String pin;
  final Function onVerified;
  final Function onNotVerified;

  VerifyUserPin({
    required this.pin,
    required this.onVerified,
    required this.onNotVerified,
  });
}

class VerifyUserBiometric {
  final Function onVerified;
  final Function onNotVerified;

  VerifyUserBiometric({
    required this.onVerified,
    required this.onNotVerified,
  });
}
