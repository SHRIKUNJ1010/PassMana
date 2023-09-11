/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/get_started/get_started_view_model.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetStartedViewModel>(
      converter: GetStartedViewModel.fromStore,
      builder: (BuildContext context, GetStartedViewModel vm) {
        return Container();
      },
    );
  }
}
