/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/password_list/password_list_view_model.dart';

class PasswordListScreen extends StatelessWidget {
  const PasswordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordListViewModel>(
      converter: PasswordListViewModel.fromStore,
      builder: (BuildContext context, PasswordListViewModel vm) {
        return Container(
          color: Colors.blue,
        );
      },
    );
  }
}
