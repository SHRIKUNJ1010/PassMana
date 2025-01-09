/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/card/card_details/card_details_view_model.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/password_details/widgets/details_action_tappable_item_widget.dart';
import 'package:passmana/presentation/password/password_details/widgets/details_item_tile.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CardDetailsScreen extends StatefulWidget {
  final int id;

  const CardDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  bool showCardPin = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CardDetailsViewModel>(
      converter: (Store<AppState> store) {
        return CardDetailsViewModel.fromStore(store, widget.id);
      },
      builder: (BuildContext context, CardDetailsViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
            body: vm.card.id == 0
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: "${AppConstants.cardHero}${vm.card.id}",
                            child: Text(
                              vm.card.bankAndCardName,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DetailsItemTile(
                        title: "${getTranslated("card_holder_name", context)}:",
                        description: vm.card.cardHolderName,
                      ),
                      //getCardHolderNameContainer(vm, context),
                      const SizedBox(height: 10),
                      DetailsItemTile(
                        title: "${getTranslated("card_number", context)}:",
                        description: vm.card.cardNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                      ),
                      const SizedBox(height: 10),
                      getExpiryDateAndCvvContainer(vm, context),
                      const SizedBox(height: 10),
                      DetailsItemTile(
                        title: "${getTranslated("card_pin", context)}:",
                        description: showCardPin ? vm.card.cardPin : vm.card.cardPin.replaceAll(RegExp(r"."), "*"),
                        actionItem: DetailsActionTappableItemWidget(
                          onItemTap: () {
                            showCardPin = !showCardPin;
                            setState(() {});
                          },
                          item: showCardPin
                              ? Icon(
                                  FontAwesome5.eye,
                                  color: Theme.of(context).textTheme.headlineSmall?.color,
                                  size: 17,
                                )
                              : Icon(
                                  FontAwesome5.eye_slash,
                                  color: Theme.of(context).textTheme.headlineSmall?.color,
                                  size: 17,
                                ),
                        ),
                      ),
                      if (vm.getSecurityGridNumbers.call().isNotEmpty) const SizedBox(height: 10),
                      if (vm.getSecurityGridNumbers.call().isNotEmpty)
                        getCommonContainer(
                          externalContainer: true,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated("grid_numbers", context)}:",
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              for (int i = 0; i < vm.getSecurityGridNumbers.call().length + 4; i += 4) ...[
                                i >= vm.getSecurityGridNumbers.call().length
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: DetailsItemTile(
                                              title: vm.getSecurityGridNumbers.call()[i].title ?? "",
                                              description: vm.getSecurityGridNumbers.call()[i].value ?? "",
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          i + 1 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: DetailsItemTile(
                                                    title: vm.getSecurityGridNumbers.call()[i + 1].title ?? "",
                                                    description: vm.getSecurityGridNumbers.call()[i + 1].value ?? "",
                                                  ),
                                                ),
                                          const SizedBox(width: 10),
                                          i + 2 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: DetailsItemTile(
                                                    title: vm.getSecurityGridNumbers.call()[i + 2].title ?? "",
                                                    description: vm.getSecurityGridNumbers.call()[i + 2].value ?? "",
                                                  ),
                                                ),
                                          const SizedBox(width: 10),
                                          i + 3 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: DetailsItemTile(
                                                    title: vm.getSecurityGridNumbers.call()[i + 3].title ?? "",
                                                    description: vm.getSecurityGridNumbers.call()[i + 3].value ?? "",
                                                  ),
                                                ),
                                        ],
                                      ),
                                i >= vm.getSecurityGridNumbers.call().length ? SizedBox() : SizedBox(height: 7),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Row getExpiryDateAndCvvContainer(CardDetailsViewModel vm, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DetailsItemTile(
            title: "${getTranslated("exp_date", context)}:",
            description: vm.card.expiryDate,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DetailsItemTile(
            title: "${getTranslated("cvv", context)}:",
            description: vm.card.cvv,
          ),
        ),
      ],
    );
  }

  Container getCommonContainer({
    required Widget child,
    bool externalContainer = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: externalContainer ? Theme.of(context).cardColor.withValues(alpha: 0.7) : Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: child,
    );
  }

  CustomAppBar getAppBar(CardDetailsViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              CommonAppBarActionIconButton(
                onItemTap: () {
                  vm.onBackPress.call();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("card_details", context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonAppBarActionIconButton(
                onItemTap: () {
                  vm.onEditTap.call();
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
