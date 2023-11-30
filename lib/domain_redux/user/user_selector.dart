/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';

bool getIsBiometricEnabled(AppState state) => state.user?.isBiometricEnabled ?? false;

bool getIsConfirmPin(AppState state) => state.user?.pin != null && state.user?.pin != "";

String getUserPin(AppState state) => state.user?.pin ?? "";

int getUserId(AppState state) => state.user?.id ?? 0;