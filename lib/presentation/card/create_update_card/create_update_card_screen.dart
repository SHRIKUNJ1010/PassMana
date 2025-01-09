/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/card_security_grid_number_list.dart';
import 'package:passmana/presentation/card/create_update_card/create_update_card_view_model.dart';
import 'package:passmana/presentation/card/create_update_card/security_grid_number_list_item_widget.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_bottom_button.dart';
import 'package:passmana/presentation/common/common_text_field.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/card_text_field_formatter.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdateCardScreen extends StatefulWidget {
  final int? id;

  const CreateUpdateCardScreen({
    super.key,
    required this.id,
  });

  @override
  State<CreateUpdateCardScreen> createState() => _CreateUpdateCardScreenState();
}

class _CreateUpdateCardScreenState extends State<CreateUpdateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController bankAndCardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardPinController = TextEditingController();
  List<SecurityGridNumber> securityGridNumberList = [];
  bool showCardPin = false;

  @override
  void dispose() {
    bankAndCardNameController.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    cvvController.dispose();
    expiryDateController.dispose();
    cardPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateCardViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateCardViewModel.fromStore(store, widget.id);
      },
      onInit: (Store<AppState> store) {
        if (widget.id != null) {
          List<SecurityGridNumber> tempSecurityGridNumberList = [];
          try {
            tempSecurityGridNumberList =
                CardSecurityGridNumberList.fromJson(jsonDecode(getCardById(store.state, widget.id)?.securityGridNumber ?? "{}")).securityGridNumerList ?? [];
          } catch (e) {
            tempSecurityGridNumberList = [];
          }
          bankAndCardNameController.text = getCardById(store.state, widget.id)?.bankAndCardName ?? "";
          cardNumberController.text =
              (getCardById(store.state, widget.id)?.cardNumber ?? "").replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
          cardHolderNameController.text = getCardById(store.state, widget.id)?.cardHolderName ?? "";
          cvvController.text = getCardById(store.state, widget.id)?.cvv ?? "";
          expiryDateController.text = getCardById(store.state, widget.id)?.expiryDate ?? "";
          cardPinController.text = getCardById(store.state, widget.id)?.cardPin ?? "";
          securityGridNumberList = tempSecurityGridNumberList;
        }
      },
      builder: (BuildContext context, CreateUpdateCardViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                //TODO: find a way to add loader while creating updating or deleting data for all create update screen
                //TODO: also add manual delay show that process can be shown that process does loads
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  appBar: getAppBar(vm, context),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            getBankAndCardName(context, bankAndCardNameController, vm.card?.id),
                            getCardNumber(context, cardNumberController),
                            getCardHolderName(context, cardHolderNameController),
                            getCvv(context, cvvController),
                            getExpiryDate(context, expiryDateController),
                            getCardPinField(context, cardPinController),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                                  child: Text(
                                    "${getTranslated('grid_numbers', context)}: (${getTranslated('optional', context)})",
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemCount: securityGridNumberList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: SecurityGridNumberListItemWidget(
                                    key: ValueKey(securityGridNumberList[index].hashCode),
                                    item: securityGridNumberList[index],
                                    onCancelTap: () {
                                      if (securityGridNumberList.length != 1) {
                                        securityGridNumberList.removeAt(index);
                                        setState(() {});
                                      } else {
                                        //do nothing
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Material(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(3),
                                  child: Container(
                                    height: 45,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        securityGridNumberList.add(SecurityGridNumber());
                                        setState(() {});
                                      },
                                      splashColor: AppColors.primaryColor.withValues(alpha: 0.3),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Theme.of(context).textTheme.headlineSmall?.color,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            getTranslated('add_field', context),
                                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 180),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: getCreateUpdateButton(vm, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column getBankAndCardName(BuildContext context, TextEditingController controller, int? cardId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: cardId != null
                  ? Hero(
                      tag: "${AppConstants.cardHero}$cardId",
                      child: Text(
                        "${getTranslated('bank_and_card_name', context)}:",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                      ),
                    )
                  : Text(
                      "${getTranslated('bank_and_card_name', context)}:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                    ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("bank_and_card_name", context),
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Column getCardNumber(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('card_number', context)}:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("card_number", context),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(),
            ],
          ),
        ),
      ],
    );
  }

  Column getCardHolderName(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('card_holder_name', context)}:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("card_holder_name", context),
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Column getCvv(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('cvv', context)}:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("cvv", context),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Column getExpiryDate(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('expiry_date', context)}:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("expiry_date", context),
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Column getCardPinField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('card_pin', context)}:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("card_pin", context),
            suffixIcon: Container(
              alignment: Alignment.center,
              height: 25,
              width: 25,
              margin: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Material(
                  color: Theme.of(context).cardColor,
                  child: InkWell(
                    onTap: () {
                      showCardPin = !showCardPin;
                      setState(() {});
                    },
                    splashColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: showCardPin
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
                ),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            obscureText: !showCardPin,
            maxLines: 1,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Widget getCreateUpdateButton(CreateUpdateCardViewModel vm, BuildContext context) {
    return CommonBottomButton(
      title: vm.card != null ? getTranslated('update', context) : getTranslated('create', context),
      onItemTap: () {
        if (_formKey.currentState!.validate()) {
          if (widget.id != null) {
            vm.updateCard.call(
              bankAndCardName: bankAndCardNameController.text,
              cardNumber: cardNumberController.text.replaceAll(' ', ''),
              cardHolderName: cardHolderNameController.text,
              cvv: cvvController.text,
              expiryDate: expiryDateController.text,
              cardPin: cardPinController.text,
              securityGridNumber: jsonEncode(CardSecurityGridNumberList(securityGridNumerList: securityGridNumberList).toJson()),
            );
          } else {
            vm.createCard.call(
              bankAndCardName: bankAndCardNameController.text,
              cardNumber: cardNumberController.text.replaceAll(' ', ''),
              cardHolderName: cardHolderNameController.text,
              cvv: cvvController.text,
              expiryDate: expiryDateController.text,
              cardPin: cardPinController.text,
              securityGridNumber: jsonEncode(CardSecurityGridNumberList(securityGridNumerList: securityGridNumberList).toJson()),
            );
          }
        }
      },
    );
  }

  CustomAppBar getAppBar(CreateUpdateCardViewModel vm, BuildContext context) {
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
        vm.card == null
            ? Hero(
                tag: AppConstants.cardHero,
                child: Text(
                  getTranslated("create_card", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
                ),
              )
            : Text(
                getTranslated("update_card", context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
              ),
        vm.card != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAppBarActionIconButton(
                      onItemTap: () {
                        vm.deleteCard.call();
                      },
                      buttonColor: Theme.of(context).textTheme.displayLarge?.color,
                      buttonSplashColor: AppColors.mWhite.withValues(alpha: 0.2),
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.mWhite,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            : const Spacer(),
      ],
    );
  }
}
