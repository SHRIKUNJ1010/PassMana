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

  User({
    this.id = 0,
    this.pin = '',
    this.isBiometricEnabled = false,
  });

  User setPin(String pin) {
    return User(
      id: id,
      pin: pin,
      isBiometricEnabled: isBiometricEnabled,
    );
  }

  changeBiometricOption(bool isBiometricEnabled) {
    return User(
      id: id,
      pin: pin,
      isBiometricEnabled: isBiometricEnabled,
    );
  }
}
