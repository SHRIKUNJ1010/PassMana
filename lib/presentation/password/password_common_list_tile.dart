/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class PasswordCommonListTile extends StatelessWidget {
  final Password password;
  final Function onTap;
  final Function onClipboardTap;

  const PasswordCommonListTile({
    required this.password,
    required this.onTap,
    required this.onClipboardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: AppColors.mWhite,
        child: InkWell(
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    password.title.trim()[0].toUpperCase(),
                    style: TextStyles.getBoldWhiteText(27),
                  ),
                ),
                Expanded(
                  child: Text(
                    password.title,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.getTitleBlueText(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.mBlack.withValues(alpha: 0.2),
                        onTap: () {
                          onClipboardTap.call();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.copy,
                            color: AppColors.primaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
