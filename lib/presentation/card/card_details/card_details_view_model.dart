/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:redux/redux.dart';

class CardDetailsViewModel {
  final Card card;

  CardDetailsViewModel({
    required this.card,
  });

  static CardDetailsViewModel fromStore(Store<AppState> store, int id) {
    return CardDetailsViewModel(
      card: getCardById(store.state, id) ?? Card(),
    );
  }
}
