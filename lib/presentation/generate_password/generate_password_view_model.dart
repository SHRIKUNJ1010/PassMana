/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:redux/redux.dart';

class GeneratePasswordViewModel {
  final Function({
    required bool hasLowercase,
    required bool hasUppercase,
    required bool hasNumeric,
    required bool hasSpecialCharacter,
    required bool hasUmlauts,
    required bool isReadable,
    required int passwordLength,
  }) generatePassword;

  final Function(String) copyToClipboard;

  GeneratePasswordViewModel({
    required this.generatePassword,
    required this.copyToClipboard,
  });

  static GeneratePasswordViewModel fromStore(Store<AppState> store) {
    return GeneratePasswordViewModel(
      generatePassword: ({
        required bool hasLowercase,
        required bool hasUppercase,
        required bool hasNumeric,
        required bool hasSpecialCharacter,
        required bool hasUmlauts,
        required bool isReadable,
        required int passwordLength,
      }) {
      },
      copyToClipboard: (value) {
      },
    );
  }
}
