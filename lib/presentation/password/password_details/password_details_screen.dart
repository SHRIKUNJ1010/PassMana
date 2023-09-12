/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/password_details/password_details_view_model.dart';

class PasswordDetailsScreen extends StatelessWidget {
  const PasswordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordDetailsViewModel>(
      converter: PasswordDetailsViewModel.fromStore,
      builder: (BuildContext context, PasswordDetailsViewModel vm) {
        return Container();
      },
    );
  }
}