/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/card/card_details/card_details_view_model.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
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
                          Text(
                            vm.card.bankAndCardName,
                            style: TextStyles.getBoldWhiteText(30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      getCardHolderNameContainer(vm, context),
                      const SizedBox(height: 10),
                      getCardNumberContainer(vm, context),
                      const SizedBox(height: 10),
                      getExpiryDateAndCvvContainer(vm, context),
                      const SizedBox(height: 10),
                      getCardPinContainer(vm, context),
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
                                style: TextStyles.getTitleDarkRedText(17),
                              ),
                              const SizedBox(height: 7),
                              for (int i = 0; i < vm.getSecurityGridNumbers.call().length + 4; i += 4) ...[
                                i >= vm.getSecurityGridNumbers.call().length
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: getCardGridItemContainer(
                                              vm.getSecurityGridNumbers.call()[i].title ?? "",
                                              vm.getSecurityGridNumbers.call()[i].value ?? "",
                                              context,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          i + 1 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: getCardGridItemContainer(
                                                    vm.getSecurityGridNumbers.call()[i + 1].title ?? "",
                                                    vm.getSecurityGridNumbers.call()[i + 1].value ?? "",
                                                    context,
                                                  ),
                                                ),
                                          const SizedBox(width: 10),
                                          i + 2 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: getCardGridItemContainer(
                                                    vm.getSecurityGridNumbers.call()[i + 2].title ?? "",
                                                    vm.getSecurityGridNumbers.call()[i + 2].value ?? "",
                                                    context,
                                                  ),
                                                ),
                                          const SizedBox(width: 10),
                                          i + 3 >= vm.getSecurityGridNumbers.call().length
                                              ? Spacer()
                                              : Expanded(
                                                  child: getCardGridItemContainer(
                                                    vm.getSecurityGridNumbers.call()[i + 3].title ?? "",
                                                    vm.getSecurityGridNumbers.call()[i + 3].value ?? "",
                                                    context,
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

  Container getCardGridItemContainer(String title, String value, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Text(
            value,
            style: TextStyles.getTitleTransparentBlackText(fontSize: 16, opacity: 1),
          ),
        ],
      ),
    );
  }

  Container getCardHolderNameContainer(CardDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("card_holder_name", context)}:",
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  vm.card.cardHolderName,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getCardNumberContainer(CardDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("card_number", context)}:",
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  vm.card.cardNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row getExpiryDateAndCvvContainer(CardDetailsViewModel vm, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: getCommonContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("exp_date", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        vm.card.expiryDate,
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyles.getTitleTransparentBlackText(
                          fontSize: 17,
                          opacity: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: getCommonContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("cvv", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        vm.card.cvv,
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyles.getTitleTransparentBlackText(
                          fontSize: 17,
                          opacity: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container getCardPinContainer(CardDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("card_pin", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  showCardPin ? vm.card.cardPin : vm.card.cardPin.replaceAll(RegExp(r"."), "*"),
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                  onTap: () {
                    showCardPin = !showCardPin;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: showCardPin
                        ? const Icon(
                            FontAwesome5.eye,
                            color: AppColors.primaryColor,
                            size: 17,
                          )
                        : const Icon(
                            FontAwesome5.eye_slash,
                            color: AppColors.primaryColor,
                            size: 17,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getCommonContainer({
    required Widget child,
    bool externalContainer = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: externalContainer ? AppColors.mWhite.withValues(alpha: 0.7) : AppColors.mWhite,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
                    onTap: () {
                      vm.onBackPress.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("card_details", context),
          style: TextStyles.getTitleWhiteText(25),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
                    onTap: () {
                      vm.onEditTap.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
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
