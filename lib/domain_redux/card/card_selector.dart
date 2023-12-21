/*
* Created by Shrikunj Patel on 12/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/card_model.dart';

Card getCardByIndex(AppState state, int index) => state.cardList![index];

Card? getCardById(AppState state, int? cardId) => cardId == null ? null : state.cardList?.singleWhere((element) => element.id == cardId);

List<Card> getCardList(AppState state) {
  return state.cardList ?? [];
}
