/*
* Created by Shrikunj Patel on 12/18/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class SearchPasswordField extends StatelessWidget {
  final Function(String) onTextChanged;

  const SearchPasswordField({
    required this.onTextChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Material(
        color: AppColors.mWhite,
        elevation: 2,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: TextField(
            onChanged: (val) {
              onTextChanged.call(val);
            },
            style: TextStyles.getTitleTransparentBlackText(fontSize: 20, opacity: 0.8),
            decoration: InputDecoration(
              hintText: getTranslated("search_password", context),
              hintStyle: TextStyles.getTitleTransparentBlackText(fontSize: 20, opacity: 0.8),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
