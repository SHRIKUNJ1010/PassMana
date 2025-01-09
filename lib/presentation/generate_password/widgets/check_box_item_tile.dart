/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class CheckBoxItemTile extends StatelessWidget {
  final bool isChecked;
  final Function() onCheckBoxTapped;
  final String primaryTextTitle;
  final String? secondaryTextTitle;

  const CheckBoxItemTile({
    super.key,
    required this.isChecked,
    required this.onCheckBoxTapped,
    required this.primaryTextTitle,
    this.secondaryTextTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                onTap: onCheckBoxTapped,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          secondaryTextTitle != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      primaryTextTitle,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
                    ),
                    Text(
                      secondaryTextTitle!,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
                    ),
                  ],
                )
              : Text(
                  primaryTextTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
                ),
        ],
      ),
    );
  }
}
