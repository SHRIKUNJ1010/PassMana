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
    TypedMiddleware<AppState, CreateCard>(_createCard()),
    TypedMiddleware<AppState, UpdateCard>(_updateCard()),
    TypedMiddleware<AppState, DeleteCard>(_deleteCard()),
    TypedMiddleware<AppState, GetAllCards>(_getAllCards()),
  ];
}

void Function(Store<AppState> store, CreateCard action, NextDispatcher next) _createCard() {
  return (store, action, next) {
    next(action);
    //add Card in object box database
    objectBox.cardBox.addCard(
      bankAndCardName: action.bankAndCardName,
      cardNumber: action.cardNumber,
      cvv: action.cvv,
      cardHolderName: action.cardHolderName,
      cardPin: action.cardPin,
      hasSecurityGrid: action.hasSecurityGrid,
      securityGridNumber: action.securityGridNumber,
    );
    //get all latest cards
    List<Card> cards = objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, UpdateCard action, NextDispatcher next) _updateCard() {
  return (store, action, next) {
    next(action);
    //update card in object box database
    objectBox.cardBox.updateCard(card: action.card);
    //get all latest cards
    List<Card> cards = objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, DeleteCard action, NextDispatcher next) _deleteCard() {
  return (store, action, next) {
    next(action);
    //delete card from object box database
    objectBox.cardBox.deleteCard(action.cardId);
    //get all latest cards
    List<Card> cards = objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}

void Function(Store<AppState> store, GetAllCards action, NextDispatcher next) _getAllCards() {
  return (store, action, next) {
    next(action);
    //get all latest cards
    List<Card> cards = objectBox.cardBox.getAllCards();
    //change the list of cards in state
    store.dispatch(CardListChanged(cardList: cards));
  };
}
