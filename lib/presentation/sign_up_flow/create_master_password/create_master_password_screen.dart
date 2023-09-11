/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/sign_up_flow/create_master_password/create_master_password_view_model.dart';

class CreateMasterPasswordScreen extends StatelessWidget {
  const CreateMasterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateMasterPasswordViewModel>(
      converter: CreateMasterPasswordViewModel.fromStore,
      builder: (BuildContext context, CreateMasterPasswordViewModel vm) {
        return Container();
      },
    );
  }
}
