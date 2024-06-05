import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/model/card_model.dart' as c;


class CardCommonListTile extends StatelessWidget {
  final c.Card card;
  final Function onTap;

  const CardCommonListTile({
    super.key,
    required this.card,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: AppColors.mWhite,
        child: InkWell(
          splashColor: AppColors.primaryColor.withOpacity(0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
