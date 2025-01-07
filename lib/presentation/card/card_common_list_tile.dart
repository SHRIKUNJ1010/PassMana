import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/card_model.dart' as c;
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

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
              color: AppColors.primaryColor.withValues(alpha: 0.6),
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
                        style: TextStyles.getBoldWhiteText(17),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi / 2,
                      child: const Icon(
                        Icons.wifi_outlined,
                        size: 27,
                        color: AppColors.mWhite,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 4),
                Text(
                  card.cardNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                  style: TextStyles.getBoldWhiteText(25),
                ),
                const Spacer(flex: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "${getTranslated("exp_date", context)}: ",
                            style: TextStyles.getTitleWhiteText(15),
                            children: <TextSpan>[TextSpan(text: card.expiryDate, style: TextStyles.getBoldWhiteText(15))]),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "${getTranslated("cvv", context)}: ",
                            style: TextStyles.getTitleWhiteText(15),
                            children: <TextSpan>[TextSpan(text: card.cvv, style: TextStyles.getBoldWhiteText(15))]),
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
                      style: TextStyles.getBoldWhiteText(20),
                    ),
                    const Icon(
                      Icons.nfc,
                      size: 27,
                      color: AppColors.mWhite,
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
