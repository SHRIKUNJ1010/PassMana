/*
* Created by Shrikunj Patel on 1/23/2024.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/password_dynamic_field_model.dart';
import 'package:passmana/presentation/common/common_text_field.dart';
import 'package:passmana/utility/color.dart';

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
            child: CommonTextField(
              initialValue: widget.item.title,
              hintText: getTranslated('title', context),
              onChanged: (val) {
                widget.item.title = val;
              },
              textInputAction: TextInputAction.next,
              isMandatory: false,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: CommonTextField(
              initialValue: widget.item.value,
              hintText: getTranslated('value', context),
              onChanged: (val) {
                widget.item.value = val;
              },
              isMandatory: false,
              textInputAction: TextInputAction.next,
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
                splashColor: AppColors.primaryColor.withValues(alpha: 0.3),
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
