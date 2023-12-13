/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/secret_note/secret_note_list/secret_note_list_view_model.dart';

class SecretNoteListScreen extends StatelessWidget {
  const SecretNoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SecretNoteListViewModel>(
      converter: SecretNoteListViewModel.fromStore,
      builder: (BuildContext context, SecretNoteListViewModel vm) {
        return Container(
          color: Colors.yellow,
        );
      },
    );
  }
}