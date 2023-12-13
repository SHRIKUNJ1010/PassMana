/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:redux/redux.dart';

class CardListViewModel {
  final List<Card> cardList;

  CardListViewModel({required this.cardList});

  static CardListViewModel fromStore(Store<AppState> store) {
    return CardListViewModel(
      cardList: getCardList(store.state),
    );
  }
}
