/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class SettingsItemTextButtonTile extends StatelessWidget {
  final Function() onTap;
  final String title;

  const SettingsItemTextButtonTile({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
            ),
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
