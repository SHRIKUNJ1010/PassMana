import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class SecretNoteCommonListTile extends StatelessWidget {
  final SecretNote secretNote;
  final Function onTap;

  const SecretNoteCommonListTile({
    super.key,
    required this.secretNote,
    required this.onTap,
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
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 250,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  secretNote.note,
                  style: TextStyles.getTitleBlueText(17),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('dd/MM/yyyy HH:mm a').format(secretNote.lastUpdatedOn),
                    style: TextStyles.getTitleBlueText(13),
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
