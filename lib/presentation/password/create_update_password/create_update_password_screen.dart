/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_view_model.dart';
import 'package:redux/redux.dart';

class CreateUpdatePasswordScreen extends StatelessWidget {
  final int id;

  const CreateUpdatePasswordScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdatePasswordViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdatePasswordViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, CreateUpdatePasswordViewModel vm) {
        return Container();
      },
    );
  }
}
