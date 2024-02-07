/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/card_model.dart';

class CardBox {
  late final Box<Card> _cardBox;

  CardBox(Store store) {
    _cardBox = Box<Card>(store);
  }

  addCard({
    String bankAndCardName = '',
    String cardNumber = '',
    String cardHolderName = '',
    String cvv = '',
    String cardPin = '',
    bool hasSecurityGrid = false,
    Map<String, String> securityGridNumber = const <String, String>{},
  }) {
    _cardBox.put(
      Card(
        bankAndCardName: bankAndCardName,
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        cvv: cvv,
        cardPin: cardPin,
        hasSecurityGrid: hasSecurityGrid,
        securityGridNumber: securityGridNumber,
        createdOn: DateTime.now(),
        lastUpdatedOn: DateTime.now(),
      ),
      mode: PutMode.insert,
    );
  }

  updateCard({
    required Card card,
  }) {
    _cardBox.put(
      card,
      mode: PutMode.update,
    );
  }

  List<Card> getAllCards() {
    return _cardBox.getAll();
  }

  Card? getOneCard(int cardId) {
    return _cardBox.get(cardId);
  }

  deleteCard(int cardId) {
    _cardBox.remove(cardId);
  }
}
