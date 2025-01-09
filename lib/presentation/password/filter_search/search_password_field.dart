/*
* Created by Shrikunj Patel on 12/18/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';

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
        color: Theme.of(context).cardColor,
        elevation: 2,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: TextField(
            onChanged: (val) {
              onTextChanged.call(val);
            },
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20),
            decoration: InputDecoration(
              hintText: getTranslated("search_password", context),
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
