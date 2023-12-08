/*
* Created by Shrikunj Patel on 12/4/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CreateListItemTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function onTap;

  const CreateListItemTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          elevation: 5,
          color: AppColors.mWhite,
          child: InkWell(
            onTap: () {
              onTap.call();
            },
            splashColor: AppColors.accentSecondaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.mWhite.withOpacity(0.7),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyles.getTitleTransparentBlackText(
                        fontSize: 25,
                        opacity: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
