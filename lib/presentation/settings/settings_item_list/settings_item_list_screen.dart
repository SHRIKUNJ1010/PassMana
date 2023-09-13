/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/settings/settings_item_list/settings_item_list_view_model.dart';

class SettingsItemListScreen extends StatelessWidget {
  const SettingsItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsItemListViewModel>(
      converter: SettingsItemListViewModel.fromStore,
      builder: (BuildContext context, SettingsItemListViewModel vm) {
        return Container();
      },
    );
  }
}
