/*
* Created by Shrikunj Patel on 12/22/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

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
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: AppColors.primaryMaterialColor[300],
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              onItemTap.call();
            },
            splashColor: AppColors.accentSecondaryColor.withOpacity(0.2),
            child: Container(
              width: width - 40,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: AppColors.mWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.title.trim()[0].toUpperCase(),
                      style: TextStyles.getBoldRedText(26),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.getTitleWhiteText(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: AppColors.mWhite.withOpacity(0.2),
                          onTap: () {
                            onClipboardTap.call();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.copy,
                              color: AppColors.mWhite,
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
