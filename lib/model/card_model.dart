/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class Card {
  @Id(assignable: true)
  int id;
  String bankAndCardName;
  String cardNumber;
  String cardHolderName;
  String securityGridNumber;
  String cvv;
  String cardPin;
  String expiryDate;
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
    this.expiryDate = '',
    this.securityGridNumber = '{}',
    required this.createdOn,
    required this.lastUpdatedOn,
  });

  Card updateCard({
    String? bankAndCardName,
    String? cardNumber,
    String? cardHolderName,
    String? cardPin,
    String? cvv,
    String? expiryDate,
    String? securityGridNumber,
    required DateTime lastUpdatedOn,
  }) {
    return Card(
      id: id,
      bankAndCardName: bankAndCardName ?? this.bankAndCardName,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardPin: cardPin ?? this.cardPin,
      cvv: cvv ?? this.cvv,
      expiryDate: expiryDate ?? this.expiryDate,
      securityGridNumber: securityGridNumber ?? this.securityGridNumber,
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json['id'],
        bankAndCardName: json['bank_and_card_name'],
        cardNumber: json['card_number'],
        cardHolderName: json['card_holder_name'],
        cardPin: json['card_pin'],
        cvv: json['cvv'],
        expiryDate: json['expiry_date'],
        securityGridNumber: json['security_grid_number'],
        createdOn: DateTime.tryParse(json['created_on']) ?? DateTime.now(),
        lastUpdatedOn: DateTime.tryParse(json['last_updated_on']) ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_and_card_name'] = bankAndCardName;
    data['card_number'] = cardNumber;
    data['card_holder_name'] = cardHolderName;
    data['card_pin'] = cardPin;
    data['cvv'] = cvv;
    data['expiry_date'] = expiryDate;
    data['security_grid_number'] = securityGridNumber;
    data['created_on'] = createdOn.toString();
    data['last_updated_on'] = lastUpdatedOn.toString();
    return data;
  }
}
