/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_view_model.dart';

class CreateUpdatePasswordScreen extends StatelessWidget {
  const CreateUpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdatePasswordViewModel>(
      converter: CreateUpdatePasswordViewModel.fromStore,
      builder: (BuildContext context, CreateUpdatePasswordViewModel vm) {
        return Container();
      },
    );
  }
}
