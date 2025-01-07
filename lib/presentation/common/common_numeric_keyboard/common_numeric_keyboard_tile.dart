/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class CommonNumericKeyboardTile extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const CommonNumericKeyboardTile({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTap.call();
              },
              splashColor: AppColors.accentPrimaryColor,
              child: Container(
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
