/*
* Created by Shrikunj Patel on 9/5/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/utility/constants.dart';

@Entity()
class User {
  @Id()
  int id;
  bool isBiometricEnabled;
  bool isAutofillEnabled;
  String pin;
  String localeString;

  User({
    this.id = 0,
    this.pin = '',
    this.isBiometricEnabled = false,
    this.isAutofillEnabled = false,
    this.localeString = AppConstants.english,
  });

  User setPin(String pinValue) {
    return User(
      id: id,
      pin: pinValue,
      isBiometricEnabled: isBiometricEnabled,
      isAutofillEnabled: isAutofillEnabled,
      localeString: localeString,
    );
  }

  User changeLanguage(String localeStringValue) {
    return User(
      id: id,
      pin: pin,
      isBiometricEnabled: isBiometricEnabled,
      isAutofillEnabled: isAutofillEnabled,
      localeString: localeStringValue,
    );
  }

  User changeBiometricOption(bool isBiometricEnabledValue) {
    return User(
      id: id,
      pin: pin,
      isBiometricEnabled: isBiometricEnabledValue,
      isAutofillEnabled: isAutofillEnabled,
      localeString: localeString,
    );
  }

  User changeAutofillOption(bool isAutofillEnabledValue) {
    return User(
      id: id,
      pin: pin,
      isBiometricEnabled: isBiometricEnabled,
      isAutofillEnabled: isAutofillEnabledValue,
      localeString: localeString,
    );
  }
}
