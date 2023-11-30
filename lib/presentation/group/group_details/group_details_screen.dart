/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/group/group_details/group_details_view_model.dart';
import 'package:redux/redux.dart';

class GroupDetailsScreen extends StatelessWidget {
  final int id;

  const GroupDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupDetailsViewModel>(
      converter: (Store<AppState> store) {
        return GroupDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, GroupDetailsViewModel vm) {
        return Container();
      },
    );
  }
}
