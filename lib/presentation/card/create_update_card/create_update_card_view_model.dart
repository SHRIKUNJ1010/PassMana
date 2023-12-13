/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:redux/redux.dart';

class CreateUpdateCardViewModel {
  final Card? card;
  final Function({
    required String bankAndCardName,
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String cardPin,
  }) createCard;

  final Function({
    required String bankAndCardName,
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String cardPin,
  }) updateCard;

  CreateUpdateCardViewModel({
    this.card,
    required this.createCard,
    required this.updateCard,
  });

  static CreateUpdateCardViewModel fromStore(Store<AppState> store, int id) {
    return CreateUpdateCardViewModel(
      card: getCardById(store.state, id),
      createCard: ({
        required String bankAndCardName,
        required String cardNumber,
        required String cardHolderName,
        required String cvv,
        required String cardPin,
      }) {
        store.dispatch(
          CreateCard(
            bankAndCardName: bankAndCardName,
            cardNumber: cardNumber,
            cardHolderName: cardHolderName,
            cardPin: cardPin,
            cvv: cvv,
          ),
        );
      },
      updateCard: ({
        required String bankAndCardName,
        required String cardNumber,
        required String cardHolderName,
        required String cvv,
        required String cardPin,
      }) {
        store.dispatch(
          UpdateCard(
            card: getCardById(store.state, id)?.updateCard(
                  bankAndCardName: bankAndCardName,
                  cardNumber: cardNumber,
                  cardHolderName: cardHolderName,
                  cardPin: cardPin,
                  cvv: cvv,
                ) ??
                Card(),
          ),
        );
      },
    );
  }
}
