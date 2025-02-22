/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createSecretNoteMiddleware() {
  return [
    TypedMiddleware<AppState, CreateSecretNote>(_createSecretNote()).call,
    TypedMiddleware<AppState, UpdateSecretNote>(_updateSecretNote()).call,
    TypedMiddleware<AppState, DeleteSecretNote>(_deleteSecretNote()).call,
    TypedMiddleware<AppState, GetAllSecretNotes>(_getAllSecretNotes()).call,
  ];
}

void Function(Store<AppState> store, CreateSecretNote action, NextDispatcher next) _createSecretNote() {
  return (store, action, next) async {
    next(action);
    //add secretNote in object box database
    await objectBox.secretNoteBox.addSecretNote(
      note: action.note,
    );
    //get all latest secretNotes
    List<SecretNote> secretNotes = await objectBox.secretNoteBox.getAllSecretNote();
    //change the list of secretNotes in state
    store.dispatch(SecretNoteListChanged(secretNoteList: secretNotes));
  };
}

void Function(Store<AppState> store, UpdateSecretNote action, NextDispatcher next) _updateSecretNote() {
  return (store, action, next) async {
    next(action);
    //update secretNote in object box database
    await objectBox.secretNoteBox.updateSecretNote(
      id: action.id,
      note: action.note,
    );
    //get all latest secretNotes
    List<SecretNote> secretNotes = await objectBox.secretNoteBox.getAllSecretNote();
    //change the list of secretNotes in state
    store.dispatch(SecretNoteListChanged(secretNoteList: secretNotes));
  };
}

void Function(Store<AppState> store, DeleteSecretNote action, NextDispatcher next) _deleteSecretNote() {
  return (store, action, next) async {
    next(action);
    //delete secretNote from object box database
    await objectBox.secretNoteBox.deleteSecretNote(action.secretNoteId);
    //get all latest secretNotes
    List<SecretNote> secretNotes = await objectBox.secretNoteBox.getAllSecretNote();
    //change the list of secretNotes in state
    store.dispatch(SecretNoteListChanged(secretNoteList: secretNotes));
  };
}

void Function(Store<AppState> store, GetAllSecretNotes action, NextDispatcher next) _getAllSecretNotes() {
  return (store, action, next) async {
    next(action);
    //get all latest secretNotes
    List<SecretNote> secretNotes = await objectBox.secretNoteBox.getAllSecretNote();
    //change the list of secretNotes in state
    store.dispatch(SecretNoteListChanged(secretNoteList: secretNotes));
  };
}
