/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/card/create_update_card/create_update_card_view_model.dart';
import 'package:redux/redux.dart';

class CreateUpdateCardScreen extends StatelessWidget {
  final int id;

  const CreateUpdateCardScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateCardViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateCardViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, CreateUpdateCardViewModel vm) {
        return Container();
      },
    );
  }
}
