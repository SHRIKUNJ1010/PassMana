/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdateCardViewModel {
  final Card? card;
  final Function({
    required String bankAndCardName,
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String expiryDate,
    required String cardPin,
    required String securityGridNumber,
  }) createCard;

  final Function({
    required String bankAndCardName,
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String expiryDate,
    required String cardPin,
    required String securityGridNumber,
  }) updateCard;
  final Function deleteCard;
  final Function onBackPress;

  CreateUpdateCardViewModel({
    this.card,
    required this.createCard,
    required this.updateCard,
    required this.deleteCard,
    required this.onBackPress,
  });

  static CreateUpdateCardViewModel fromStore(Store<AppState> store, int? id) {
    return CreateUpdateCardViewModel(
      card: getCardById(store.state, id),
      createCard: ({
        required String bankAndCardName,
        required String cardNumber,
        required String cardHolderName,
        required String cvv,
        required String expiryDate,
        required String cardPin,
        required String securityGridNumber,
      }) {
        store.dispatch(
          CreateCard(
            bankAndCardName: bankAndCardName,
            cardNumber: cardNumber,
            cardHolderName: cardHolderName,
            cardPin: cardPin,
            cvv: cvv,
            expiryDate: expiryDate,
            securityGridNumber: securityGridNumber,
          ),
        );
        router.pop();
      },
      updateCard: ({
        required String bankAndCardName,
        required String cardNumber,
        required String cardHolderName,
        required String cvv,
        required String expiryDate,
        required String cardPin,
        required String securityGridNumber,
      }) {
        store.dispatch(
          UpdateCard(
            id: id ?? 0,
            bankAndCardName: bankAndCardName,
            cardNumber: cardNumber,
            cardHolderName: cardHolderName,
            cardPin: cardPin,
            cvv: cvv,
            expiryDate: expiryDate,
            securityGridNumber: securityGridNumber,
          ),
        );
        router.pop();
      },
      deleteCard: () async {
        bool hasConfirmed = await Utility.deleteConfirmationDialog();
        if (hasConfirmed) {
          store.dispatch(DeleteCard(cardId: id ?? 0));
          router.go(AppRoutes.cardList);
        }
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
