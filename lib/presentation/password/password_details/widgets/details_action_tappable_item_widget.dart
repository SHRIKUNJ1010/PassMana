/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class DetailsActionTappableItemWidget extends StatelessWidget {
  final Function() onItemTap;
  final Widget item;

  const DetailsActionTappableItemWidget({
    super.key,
    required this.onItemTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          onTap: onItemTap,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: item,
          ),
        ),
      ),
    );
  }
}
