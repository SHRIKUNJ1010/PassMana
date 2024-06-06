/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/card/create_update_card/create_update_card_view_model.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/card_text_field_formatter.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
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
  bool hasSecurityGrid = false;

  //TODO: use dynamic form field to get security grid number and create its variable
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
          bankAndCardNameController.text = getCardById(store.state, widget.id)?.bankAndCardName ?? "";
          cardNumberController.text = (getCardById(store.state, widget.id)?.cardNumber ?? "").replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
          cardHolderNameController.text = getCardById(store.state, widget.id)?.cardHolderName ?? "";
          cvvController.text = getCardById(store.state, widget.id)?.cvv ?? "";
          expiryDateController.text = getCardById(store.state, widget.id)?.expiryDate ?? "";
          cardPinController.text = getCardById(store.state, widget.id)?.cardPin ?? "";
          hasSecurityGrid = getCardById(store.state, widget.id)?.hasSecurityGrid ?? false;
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
                            getBankAndCardName(context, bankAndCardNameController),
                            getCardNumber(context, cardNumberController),
                            getCardHolderName(context, cardHolderNameController),
                            getCvv(context, cvvController),
                            getExpiryDate(context, expiryDateController),
                            getCardPinField(context, cardPinController),
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

  Column getBankAndCardName(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('bank_and_card_name', context)}:",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("bank_and_card_name", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
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
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("card_number", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
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
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("card_holder_name", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
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
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("cvv", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
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
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("expiry_date", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
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
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("card_pin", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
                margin: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Material(
                    color: AppColors.mWhite,
                    child: InkWell(
                      onTap: () {
                        showCardPin = !showCardPin;
                        setState(() {});
                      },
                      splashColor: AppColors.secondaryColor.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            obscureText: !showCardPin,
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  ClipRRect getCreateUpdateButton(CreateUpdateCardViewModel vm, BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: InkWell(
          splashColor: AppColors.mWhite.withOpacity(0.2),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (widget.id != null) {
                vm.updateCard.call(
                  bankAndCardName: bankAndCardNameController.text,
                  cardNumber: cardNumberController.text.replaceAll(' ', ''),
                  cardHolderName: cardHolderNameController.text,
                  cvv: cvvController.text,
                  expiryDate: expiryDateController.text,
                  cardPin: cardPinController.text,
                  hasSecurityGrid: hasSecurityGrid,
                  securityGridNumber: <String, String>{},
                );
              } else {
                vm.createCard.call(
                  bankAndCardName: bankAndCardNameController.text,
                  cardNumber: cardNumberController.text.replaceAll(' ', ''),
                  cardHolderName: cardHolderNameController.text,
                  cvv: cvvController.text,
                  expiryDate: expiryDateController.text,
                  cardPin: cardPinController.text,
                  hasSecurityGrid: hasSecurityGrid,
                  securityGridNumber: <String, String>{},
                );
              }
            }
          },
          child: Container(
            height: 65,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              vm.card != null ? getTranslated('update', context) : getTranslated('create', context),
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
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
          vm.card != null ? getTranslated("update_card", context) : getTranslated("create_card", context),
          style: TextStyles.getTitleWhiteText(25),
        ),
        vm.card != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: AppColors.secondaryMaterialColor[700],
                        child: InkWell(
                          splashColor: AppColors.mWhite.withOpacity(0.2),
                          onTap: () {
                            vm.deleteCard.call();
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.mWhite,
                              size: 25,
                            ),
                          ),
                        ),
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
