/*
Created By Shrikunj on 03/01/25
*/
import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/card_security_grid_number_list.dart';
import 'package:passmana/utility/color.dart';

class SecurityGridNumberListItemWidget extends StatefulWidget {
  final SecurityGridNumber item;
  final Function onCancelTap;

  const SecurityGridNumberListItemWidget({
    super.key,
    required this.item,
    required this.onCancelTap,
  });

  @override
  State<SecurityGridNumberListItemWidget> createState() => _SecurityGridNumberListItemWidgetState();
}

class _SecurityGridNumberListItemWidgetState extends State<SecurityGridNumberListItemWidget> {
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
              onChanged: (val) {
                widget.item.title = val;
              },
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                errorStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 20,
                      color: AppColors.mFF9C00,
                    ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(3),
                ),
                hintText: getTranslated('title', context),
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
              onChanged: (val) {
                widget.item.value = val;
              },
              decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                errorStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 20,
                      color: AppColors.mFF9C00,
                    ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(3),
                ),
                hintText: getTranslated('value', context),
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
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
            borderRadius: BorderRadius.circular(3),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  widget.onCancelTap.call();
                },
                splashColor: AppColors.primaryColor.withValues(alpha: 0.3),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.cancel,
                    color: Theme.of(context).textTheme.displaySmall?.color,
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
