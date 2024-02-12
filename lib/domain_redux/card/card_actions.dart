/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/model/card_model.dart';

class GetAllCards {}

class CreateCard {
  final String bankAndCardName;
  final String cardNumber;
  final String cvv;
  final String cardHolderName;
  final String cardPin;
  final String expiryDate;
  final bool hasSecurityGrid;
  final Map<String,String> securityGridNumber;

  CreateCard({
    required this.bankAndCardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardPin,
    required this.cvv,
    required this.expiryDate,
    required this.hasSecurityGrid,
    required this.securityGridNumber,
  });
}

class UpdateCard {
  final Card card;

  UpdateCard({
    required this.card,
  });
}

class DeleteCard {
  final int cardId;

  DeleteCard({
    required this.cardId,
  });
}

class CardListChanged {
  final List<Card> cardList;

  CardListChanged({
    required this.cardList,
  });
}
