/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CardListViewModel {
  final List<Card> cardList;
  final Function(int) onCardTileTap;

  CardListViewModel({
    required this.cardList,
    required this.onCardTileTap,
  });

  static CardListViewModel fromStore(Store<AppState> store) {
    return CardListViewModel(
      cardList: getCardList(store.state),
      onCardTileTap: (id) {
        router.push(AppRoutes.cardDetails, extra: id);
      },
    );
  }
}
