/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/settings/change_master_password/change_master_password_view_model.dart';

class ChangeMasterPasswordScreen extends StatelessWidget {
  const ChangeMasterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangeMasterPasswordViewModel>(
      converter: ChangeMasterPasswordViewModel.fromStore,
      builder: (BuildContext context, ChangeMasterPasswordViewModel vm) {
        return Container();
      },
    );
  }
}
