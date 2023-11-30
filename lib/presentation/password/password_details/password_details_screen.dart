/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/password_details/password_details_view_model.dart';
import 'package:redux/redux.dart';

class PasswordDetailsScreen extends StatelessWidget {
  final int id;

  const PasswordDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordDetailsViewModel>(
      converter: (Store<AppState> store) {
        return PasswordDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, PasswordDetailsViewModel vm) {
        return Container();
      },
    );
  }
}
