/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class Card {
  @Id()
  int id;
  String bankAndCardName;
  String cardNumber;
  String cardHolderName;
  String cvv;
  String cardPin;
  @Property(type: PropertyType.date)
  DateTime createdOn;
  @Property(type: PropertyType.date)
  DateTime lastUpdatedOn;

  Card({
    this.id = 0,
    this.bankAndCardName = '',
    this.cardNumber = '',
    this.cardHolderName = '',
    this.cardPin = '',
    this.cvv = '',
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  Card updateCard({
    String? bankAndCardName,
    String? cardNumber,
    String? cardHolderName,
    String? cardPin,
    String? cvv,
    required DateTime lastUpdatedOn,
  }) {
    return Card(
      id: id,
      bankAndCardName: bankAndCardName ?? this.bankAndCardName,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardPin: cardPin ?? this.cardPin,
      cvv: cvv ?? this.cvv,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }
}
