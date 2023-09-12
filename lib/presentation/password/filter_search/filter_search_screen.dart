/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/password/filter_search/filter_search_view_model.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FilterSearchViewModel>(
      converter: FilterSearchViewModel.fromStore,
      builder: (BuildContext context, FilterSearchViewModel vm) {
        return Container();
      },
    );
  }
}
