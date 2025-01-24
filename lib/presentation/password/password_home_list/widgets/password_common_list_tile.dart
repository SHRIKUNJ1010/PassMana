/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';

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
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: "${AppConstants.passwordHero}${password.id}",
                    child: Text(
                      password.title.trim()[0].toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 27),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    password.title,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).cardTheme.color,
                        ),
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
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.copy,
                            color: Theme.of(context).cardTheme.color,
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
