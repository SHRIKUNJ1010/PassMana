/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/settings/generate_password/generate_password_stateful_container.dart';
import 'package:passmana/presentation/settings/generate_password/generate_password_view_model.dart';

class GeneratePasswordScreen extends StatelessWidget {
  const GeneratePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GeneratePasswordViewModel>(
      converter: GeneratePasswordViewModel.fromStore,
      builder: (BuildContext context, GeneratePasswordViewModel vm) {
        return GeneratePasswordStatefulContainer(vm: vm);
      },
    );
  }
}
