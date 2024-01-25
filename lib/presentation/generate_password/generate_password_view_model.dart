/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/screen_argument_models/create_update_password_screen_arguments.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/cryptography_utility/password_generator.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class GeneratePasswordViewModel {
  final String Function({
    required bool hasLowercase,
    required bool hasUppercase,
    required bool hasNumeric,
    required bool hasSpecialCharacter,
    required int passwordLength,
    required bool isReadable,
  }) generatePassword;
  final Function(String) onCopyPasswordTap;
  final Function(String) onUsePasswordTap;
  final Function onBackPress;

  GeneratePasswordViewModel({
    required this.generatePassword,
    required this.onCopyPasswordTap,
    required this.onUsePasswordTap,
    required this.onBackPress,
  });

  static GeneratePasswordViewModel fromStore(Store<AppState> store) {
    return GeneratePasswordViewModel(
      generatePassword: ({
        required bool hasLowercase,
        required bool hasUppercase,
        required bool hasNumeric,
        required bool hasSpecialCharacter,
        required int passwordLength,
        required bool isReadable,
      }) {
        String tempPassword = "";
        if (isReadable) {
          tempPassword = PasswordGenerator.generatePronounceablePassword(
            length: passwordLength,
            withLowerCase: hasLowercase,
            withUpperCase: hasUppercase,
            withSpecialChar: hasSpecialCharacter,
            withDigits: hasNumeric,
          );
        } else {
          tempPassword = PasswordGenerator.generateRandomPassword(
            length: passwordLength,
            withLowerCase: hasLowercase,
            withUpperCase: hasUppercase,
            withSpecialChar: hasSpecialCharacter,
            withDigits: hasNumeric,
          );
        }
        return tempPassword;
      },
      onUsePasswordTap: (value) {
        router.go(AppRoutes.passwordHomeList);
        router.push(
          AppRoutes.createUpdatePassword,
          extra: CreateUpdatePasswordScreenArguments(
            generatedPassword: value,
          ),
        );
      },
      onCopyPasswordTap: (value) {
        Utility.copyToClipboard(value);
      },
      onBackPress: () async {
        bool? value = await Utility.discardDataConfirmationDialog();
        if (value) {
          router.pop();
        }
      },
    );
  }
}
