/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/group/group_list/group_list_view_model.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupListViewModel>(
      converter: GroupListViewModel.fromStore,
      builder: (BuildContext context, GroupListViewModel vm) {
        return Container(
          color: Colors.yellow,
        );
      },
    );
  }
}
