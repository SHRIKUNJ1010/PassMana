/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/group/create_update_group/create_update_group_view_model.dart';

class CreateUpdateGroupScreen extends StatelessWidget {
  const CreateUpdateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateGroupViewModel>(
      converter: CreateUpdateGroupViewModel.fromStore,
      builder: (BuildContext context, CreateUpdateGroupViewModel vm) {
        return Container();
      },
    );
  }
}
