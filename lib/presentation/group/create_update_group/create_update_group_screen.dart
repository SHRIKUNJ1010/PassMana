/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/group/create_update_group/create_update_group_view_model.dart';
import 'package:redux/redux.dart';

class CreateUpdateGroupScreen extends StatelessWidget {
  final int id;

  const CreateUpdateGroupScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateGroupViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateGroupViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, CreateUpdateGroupViewModel vm) {
        return Container();
      },
    );
  }
}
