/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  final bool isBiometricEnabled;
  final Function verifyPin;
  final Function verifyBiometric;

  AuthenticationViewModel({
    required this.isBiometricEnabled,
    required this.verifyBiometric,
    required this.verifyPin,
  });

  static AuthenticationViewModel fromStore(Store<AppState> store) {
    return AuthenticationViewModel(
      isBiometricEnabled: store.state.user?.isBiometricEnabled ?? false,
      verifyBiometric: () {
        //todo: check if biometric enabled verify by biometric and navigate to home screen
      },
      verifyPin: () {
        //todo: verify by pin and navigate to home screen
      },
    );
  }
}
