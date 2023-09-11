/*
* Created by Shrikunj Patel on 8/28/2023.
*/

import 'package:passmana/model/user_model.dart';

class CreateUser {
  final String masterPassword;
  final String pin;

  CreateUser({
    required this.masterPassword,
    required this.pin,
  });
}

class UpdateMasterPassword {
  final String masterPassword;

  UpdateMasterPassword({
    required this.masterPassword,
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

class SwitchBiometricOption {}
