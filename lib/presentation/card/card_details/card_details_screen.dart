/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/card/card_details/card_details_view_model.dart';
import 'package:redux/redux.dart';

class CardDetailsScreen extends StatelessWidget {
  final int id;

  const CardDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CardDetailsViewModel>(
      converter: (Store<AppState> store) {
        return CardDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, CardDetailsViewModel vm) {
        return Container();
      },
    );
  }
}