/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/sign_up_flow/create_mobile_pin/create_mobile_pin_view_model.dart';

class CreateMobilePinScreen extends StatelessWidget {
  const CreateMobilePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateMobilePinViewModel>(
      converter: CreateMobilePinViewModel.fromStore,
      builder: (BuildContext context, CreateMobilePinViewModel vm) {
        return Container();
      },
    );
  }
}
