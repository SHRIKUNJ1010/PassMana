/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/secret_note/create_update_secret_note/create_update_secret_note_view_model.dart';
import 'package:redux/redux.dart';

class CreateUpdateSecretNoteScreen extends StatelessWidget {
  final int id;

  const CreateUpdateSecretNoteScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateSecretNoteViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateSecretNoteViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, CreateUpdateSecretNoteViewModel vm) {
        return Container();
      },
    );
  }
}
