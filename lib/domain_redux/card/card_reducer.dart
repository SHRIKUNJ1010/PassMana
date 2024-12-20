/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:redux/redux.dart';

final cardReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, CardListChanged>(_onCardListChanged).call,
];

AppState _onCardListChanged(AppState state, CardListChanged action) {
  return state.copyWith(cardList: action.cardList);
}
