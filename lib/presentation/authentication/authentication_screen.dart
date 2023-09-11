/*
* Created by Shrikunj Patel on 9/11/2023.
*/
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/authentication/authentication_view_model.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthenticationViewModel>(
      converter: AuthenticationViewModel.fromStore,
      builder: (BuildContext context, AuthenticationViewModel vm) {
        return Container();
      },
    );
  }
}
