/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'dart:ui';

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_selector.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class SettingsItemListViewModel {
  final Function() onChangeMobilePinTap;
  final Function(Locale) onChangeLocaleTap;
  final Function(bool) onChangeAutofill;
  final Function(bool) onChangeBiometric;
  final bool isBiometricEnabled;
  final bool isAutofillEnabled;
  final Locale selectedLanguage;

  SettingsItemListViewModel({
    required this.onChangeMobilePinTap,
    required this.onChangeLocaleTap,
    required this.onChangeAutofill,
    required this.onChangeBiometric,
    required this.isBiometricEnabled,
    required this.isAutofillEnabled,
    required this.selectedLanguage,
  });

  static SettingsItemListViewModel fromStore(Store<AppState> store) {
    return SettingsItemListViewModel(
      isAutofillEnabled: getIsAutofillEnabled(store.state),
      isBiometricEnabled: getIsBiometricEnabled(store.state),
      selectedLanguage: getUserLocale(store.state),
      onChangeLocaleTap: (locale) {
        store.dispatch(
          ChangeLanguage(
            languageValue: locale.languageCode,
          ),
        );
      },
      onChangeMobilePinTap: () {
        router.push(AppRoutes.changeMobilePin);
      },
      onChangeAutofill: (val) {},
      onChangeBiometric: (val) {
        store.dispatch(SwitchBiometricOption());
      },
    );
  }
}
