/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/card_model.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';

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
    String expiryDate = '',
    String cardPin = '',
    String securityGridNumber = '{}',
  }) async {
    String tempBankAndCardName = await CryptoUtility.encryptText(bankAndCardName);
    String tempCardNumber = await CryptoUtility.encryptText(cardNumber);
    String tempCardHolderName = await CryptoUtility.encryptText(cardHolderName);
    String tempCvv = await CryptoUtility.encryptText(cvv);
    String tempExpiryDate = await CryptoUtility.encryptText(expiryDate);
    String tempCardPin = await CryptoUtility.encryptText(cardPin);
    String tempSecurityGridNumber = await CryptoUtility.encryptText(securityGridNumber);

    await _cardBox.putAsync(
      Card(
        bankAndCardName: tempBankAndCardName,
        cardNumber: tempCardNumber,
        cardHolderName: tempCardHolderName,
        cvv: tempCvv,
        expiryDate: tempExpiryDate,
        cardPin: tempCardPin,
        securityGridNumber: tempSecurityGridNumber,
        createdOn: DateTime.now(),
        lastUpdatedOn: DateTime.now(),
      ),
      mode: PutMode.insert,
    );
  }

  updateCard({
    required int id,
    String bankAndCardName = '',
    String cardNumber = '',
    String cardHolderName = '',
    String cvv = '',
    String expiryDate = '',
    String cardPin = '',
    String securityGridNumber = '{}',
  }) async {
    String tempBankAndCardName = await CryptoUtility.encryptText(bankAndCardName);
    String tempCardNumber = await CryptoUtility.encryptText(cardNumber);
    String tempCardHolderName = await CryptoUtility.encryptText(cardHolderName);
    String tempCvv = await CryptoUtility.encryptText(cvv);
    String tempExpiryDate = await CryptoUtility.encryptText(expiryDate);
    String tempCardPin = await CryptoUtility.encryptText(cardPin);
    String tempSecurityGridNumber = await CryptoUtility.encryptText(securityGridNumber);

    final Card tempCardModel = (await getOneCard(id))?.updateCard(
          bankAndCardName: tempBankAndCardName,
          cardNumber: tempCardNumber,
          cardHolderName: tempCardHolderName,
          cvv: tempCvv,
          expiryDate: tempExpiryDate,
          cardPin: tempCardPin,
          securityGridNumber: tempSecurityGridNumber,
          lastUpdatedOn: DateTime.now(),
        ) ??
        Card(
          createdOn: DateTime.now(),
          lastUpdatedOn: DateTime.now(),
        );

    await _cardBox.putAsync(
      tempCardModel,
      mode: PutMode.update,
    );
  }

  Future<List<Card>> getAllCards() async {
    List<Card> tempCards = [];

    for (Card element in _cardBox.getAll()) {
      String tempBankAndCardName = await CryptoUtility.decryptText(element.bankAndCardName);
      String tempCardNumber = await CryptoUtility.decryptText(element.cardNumber);
      String tempCardHolderName = await CryptoUtility.decryptText(element.cardHolderName);
      String tempCvv = await CryptoUtility.decryptText(element.cvv);
      String tempExpiryDate = await CryptoUtility.decryptText(element.expiryDate);
      String tempCardPin = await CryptoUtility.decryptText(element.cardPin);
      String tempSecurityGridNumber = await CryptoUtility.decryptText(element.securityGridNumber);
      tempCards.add(
        element.updateCard(
          bankAndCardName: tempBankAndCardName,
          cardNumber: tempCardNumber,
          cardHolderName: tempCardHolderName,
          cvv: tempCvv,
          expiryDate: tempExpiryDate,
          cardPin: tempCardPin,
          securityGridNumber: tempSecurityGridNumber,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempCards;
  }

  addAllCards(List<Card> tempCards) async {
    List<Card> temp = [];

    for (Card element in tempCards) {
      String tempBankAndCardName = await CryptoUtility.encryptText(element.bankAndCardName);
      String tempCardNumber = await CryptoUtility.encryptText(element.cardNumber);
      String tempCardHolderName = await CryptoUtility.encryptText(element.cardHolderName);
      String tempCvv = await CryptoUtility.encryptText(element.cvv);
      String tempExpiryDate = await CryptoUtility.encryptText(element.expiryDate);
      String tempCardPin = await CryptoUtility.encryptText(element.cardPin);
      String tempSecurityGridNumber = await CryptoUtility.encryptText(element.securityGridNumber);
      temp.add(
        element.updateCard(
          bankAndCardName: tempBankAndCardName,
          cardNumber: tempCardNumber,
          cardHolderName: tempCardHolderName,
          cvv: tempCvv,
          expiryDate: tempExpiryDate,
          cardPin: tempCardPin,
          securityGridNumber: tempSecurityGridNumber,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    await _cardBox.putManyAsync(temp);
  }

  Future<Card?> getOneCard(int cardId) async {
    Card tempCardValue = _cardBox.get(cardId) ??
        Card(
          id: cardId,
          createdOn: DateTime.now(),
          lastUpdatedOn: DateTime.now(),
        );
    String tempBankAndCardName = await CryptoUtility.decryptText(tempCardValue.bankAndCardName);
    String tempCardNumber = await CryptoUtility.decryptText(tempCardValue.cardNumber);
    String tempCardHolderName = await CryptoUtility.decryptText(tempCardValue.cardHolderName);
    String tempCvv = await CryptoUtility.decryptText(tempCardValue.cvv);
    String tempExpiryDate = await CryptoUtility.decryptText(tempCardValue.expiryDate);
    String tempCardPin = await CryptoUtility.decryptText(tempCardValue.cardPin);
    String tempSecurityGridNumber = await CryptoUtility.decryptText(tempCardValue.securityGridNumber);

    return tempCardValue.updateCard(
      bankAndCardName: tempBankAndCardName,
      cardNumber: tempCardNumber,
      cardHolderName: tempCardHolderName,
      cvv: tempCvv,
      expiryDate: tempExpiryDate,
      cardPin: tempCardPin,
      securityGridNumber: tempSecurityGridNumber,
      lastUpdatedOn: tempCardValue.lastUpdatedOn,
    );
  }

  deleteCard(int cardId) async {
    await _cardBox.removeAsync(cardId);
  }
}
