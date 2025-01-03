/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/card_model.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createCardMiddleware() {
  return [
    TypedMiddleware<AppState, CreateCard>(_createCard()).call,
    TypedMiddleware<AppState, UpdateCard>(_updateCard()).call,
    TypedMiddleware<AppState, DeleteCard>(_deleteCard()).call,
    TypedMiddleware<AppState, GetAllCards>(_getAllCards()).call,
  ];
}

void Function(Store<AppState> store, CreateCard action, NextDispatcher next) _createCard() {
  return (store, action, next) async {
    next(action);
    //add Card in object box database
    await objectBox.cardBox.addCard(
      bankAndCardName: action.bankAndCardName,
      cardNumber: action.cardNumber,
      cvv: action.cvv,
      expiryDate: action.expiryDate,
      cardHolderName: action.cardHolderName,
      cardPin: action.cardPin,
      securityGridNumber: action.securityGridNumber,
    );
    //get all latest cards
    List<Card> cards = await objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, UpdateCard action, NextDispatcher next) _updateCard() {
  return (store, action, next) async {
    next(action);
    //update card in object box database
    await objectBox.cardBox.updateCard(
      id: action.id,
      bankAndCardName: action.bankAndCardName,
      cardNumber: action.cardNumber,
      cvv: action.cvv,
      expiryDate: action.expiryDate,
      cardHolderName: action.cardHolderName,
      cardPin: action.cardPin,
      securityGridNumber: action.securityGridNumber,
    );
    //get all latest cards
    List<Card> cards = await objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, DeleteCard action, NextDispatcher next) _deleteCard() {
  return (store, action, next) async {
    next(action);
    //delete card from object box database
    await objectBox.cardBox.deleteCard(action.cardId);
    //get all latest cards
    List<Card> cards = await objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, GetAllCards action, NextDispatcher next) _getAllCards() {
  return (store, action, next) async {
    next(action);
    //get all latest cards
    List<Card> cards = await objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}
