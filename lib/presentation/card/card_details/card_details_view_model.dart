/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'dart:convert';

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/model/card_model.dart';
import 'package:passmana/model/card_security_grid_number_list.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CardDetailsViewModel {
  final Card card;
  final Function onBackPress;
  final Function onEditTap;
  final List<SecurityGridNumber> Function() getSecurityGridNumbers;

  CardDetailsViewModel({
    required this.card,
    required this.getSecurityGridNumbers,
    required this.onBackPress,
    required this.onEditTap,
  });

  static CardDetailsViewModel fromStore(Store<AppState> store, int id) {
    return CardDetailsViewModel(
      card: getCardById(store.state, id) ??
          Card(
            createdOn: DateTime.now(),
            lastUpdatedOn: DateTime.now(),
          ),
      getSecurityGridNumbers: () {
        List<SecurityGridNumber> tempList = [];
        try {
          tempList = CardSecurityGridNumberList.fromJson(jsonDecode(getCardById(store.state, id)?.securityGridNumber ?? "{}")).securityGridNumerList ?? [];
        } catch (e) {
          tempList = [];
        }
        return tempList;
      },
      onBackPress: () {
        router.pop();
      },
      onEditTap: () {
        router.push(AppRoutes.createUpdateCard, extra: id);
      },
    );
  }
}
