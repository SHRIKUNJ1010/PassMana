/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'dart:ui';

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/utility/constants.dart';

bool getIsBiometricEnabled(AppState state) => state.user?.isBiometricEnabled ?? false;

bool getIsAutofillEnabled(AppState state) => state.user?.isAutofillEnabled ?? false;

String getUserPin(AppState state) => state.user?.pin ?? "";

int getUserId(AppState state) => state.user?.id ?? 0;

Locale getUserLocale(AppState state) => Locale(state.user?.localeString ?? AppConstants.english);
