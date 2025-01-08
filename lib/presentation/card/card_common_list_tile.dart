import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/card_model.dart' as c;
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';

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
      borderRadius: BorderRadius.circular(3),
      child: Material(
        color: AppColors.mWhite.withValues(alpha: 0.3), //withOpacity(0.2),
        child: InkWell(
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "${AppConstants.cardHero}${card.id}",
                      child: Text(
                        card.bankAndCardName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi / 2,
                      child: Icon(
                        Icons.wifi_outlined,
                        size: 27,
                        color: Theme.of(context).textTheme.displaySmall?.color,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 4),
                Text(
                  card.cardNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 25),
                ),
                const Spacer(flex: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "${getTranslated("exp_date", context)}: ",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                              text: card.expiryDate,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "${getTranslated("cvv", context)}: ",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                              text: card.cvv,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.cardHolderName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                    ),
                    Icon(
                      Icons.nfc,
                      size: 27,
                      color: Theme.of(context).textTheme.displaySmall?.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
