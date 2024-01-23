/*
* Created by Shrikunj Patel on 1/23/2024.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/password_dynamic_field_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class PasswordDynamicFieldListItemWidget extends StatefulWidget {
  final PasswordDynamicField item;
  final Function onCancelTap;

  const PasswordDynamicFieldListItemWidget({
    super.key,
    required this.item,
    required this.onCancelTap,
  });

  @override
  State<PasswordDynamicFieldListItemWidget> createState() => _PasswordDynamicFieldListItemWidgetState();
}

class _PasswordDynamicFieldListItemWidgetState extends State<PasswordDynamicFieldListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
            child: TextFormField(
              initialValue: widget.item.title,
              validator: (text) => null,
              style: TextStyles.getTitleBlueText(18),
              onChanged: (val) {
                widget.item.title = val;
              },
              decoration: InputDecoration(
                fillColor: AppColors.mWhite,
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                errorStyle: TextStyles.getTitleOrangeText(20),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: getTranslated('title', context),
                hintStyle: TextStyles.getTitleBlueText(17),
              ),
              textInputAction: TextInputAction.next,
              onTapOutside: (pointerDown) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: TextFormField(
              initialValue: widget.item.value,
              validator: (text) => null,
              style: TextStyles.getTitleBlueText(18),
              onChanged: (val) {
                widget.item.value = val;
              },
              decoration: InputDecoration(
                fillColor: AppColors.mWhite,
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                errorStyle: TextStyles.getTitleOrangeText(20),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: getTranslated('value', context),
                hintStyle: TextStyles.getTitleBlueText(17),
              ),
              textInputAction: TextInputAction.next,
              onTapOutside: (pointerDown) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  widget.onCancelTap.call();
                },
                splashColor: AppColors.primaryColor.withOpacity(0.3),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.cancel,
                    color: AppColors.mWhite,
                    size: 27,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
