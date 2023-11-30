/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/create/create_list/create_list_view_model.dart';

class CreateListScreen extends StatelessWidget {
  const CreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateListViewModel>(
      converter: CreateListViewModel.fromStore,
      builder: (BuildContext context, CreateListViewModel vm) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
