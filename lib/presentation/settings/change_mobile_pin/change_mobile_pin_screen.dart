/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/settings/change_mobile_pin/change_mobile_pin_view_model.dart';

class ChangeMobilePinScreen extends StatelessWidget {
  const ChangeMobilePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangeMobilePinViewModel>(
      converter: ChangeMobilePinViewModel.fromStore,
      builder: (BuildContext context, ChangeMobilePinViewModel vm) {
        return Container();
      },
    );
  }
}
