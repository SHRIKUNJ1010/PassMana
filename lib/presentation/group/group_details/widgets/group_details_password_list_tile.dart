/*
* Created by Shrikunj Patel on 12/22/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';

class GroupPasswordListTile extends StatelessWidget {
  final double width;
  final Password item;
  final Function onItemTap;
  final Function onClipboardTap;

  const GroupPasswordListTile({
    super.key,
    required this.width,
    required this.item,
    required this.onItemTap,
    required this.onClipboardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Material(
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(3),
          child: InkWell(
            onTap: () {
              onItemTap.call();
            },
            splashColor: AppColors.accentSecondaryColor.withValues(alpha: 0.2),
            child: Container(
              width: width - 40,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "${AppConstants.passwordHero}${item.id}",
                      child: Text(
                        item.title.trim()[0].toUpperCase(),
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 26),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                          onTap: () {
                            onClipboardTap.call();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.copy,
                              color: Theme.of(context).textTheme.displaySmall?.color,
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
      ),
    );
  }
}
