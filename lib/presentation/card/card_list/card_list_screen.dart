/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/card/card_list/card_list_view_model.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CardListViewModel>(
      converter: CardListViewModel.fromStore,
      builder: (BuildContext context, CardListViewModel vm) {
        return Container(
          color: Colors.yellow,
        );
      },
    );
  }
}