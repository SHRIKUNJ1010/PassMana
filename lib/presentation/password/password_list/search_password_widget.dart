/*
* Created by Shrikunj Patel on 12/18/2023.
*/

import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class SearchPasswordWidget extends StatefulWidget {
  final Function(String) onChange;
  final Function(String) onSubmit;

  const SearchPasswordWidget({
    required this.onChange,
    required this.onSubmit,
    super.key,
  });

  @override
  State<SearchPasswordWidget> createState() => _SearchPasswordWidgetState();
}

class _SearchPasswordWidgetState extends State<SearchPasswordWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.mWhite,
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  widget.onChange.call(val);
                },
                onSubmitted: (val) {
                  widget.onSubmit.call(val);
                },
                decoration: InputDecoration(
                  hintText: getTranslated("search_password"),
                  hintStyle: TextStyles.getTitleTransparentBlackText(fontSize: 20, opacity: 0.8),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    gapPadding: 0,
                  ),
                ),
              ),
            ),
          ),
          //todo: add on tap with splash effect
          Container(
            width: 55,
            height: 55,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(13),
            ),
            alignment: Alignment.center,
            child: const Icon(
              WebSymbols.search,
              size: 25,
              color: AppColors.mWhite,
            ),
          )
        ],
      ),
    );
  }
}
