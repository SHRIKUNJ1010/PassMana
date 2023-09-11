/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  bool isBiometricEnabled;
  String pin;
  String masterPassword;

  User({
    this.id = 0,
    this.masterPassword = '',
    this.pin = '',
    this.isBiometricEnabled = false,
  });

  setPin(String pin) {
    this.pin = pin;
  }

  setMasterPassword(String masterPassword) {
    this.masterPassword = masterPassword;
  }

  changeBiometricOption(bool isBiometricEnabled) {
    this.isBiometricEnabled = isBiometricEnabled;
  }
}
