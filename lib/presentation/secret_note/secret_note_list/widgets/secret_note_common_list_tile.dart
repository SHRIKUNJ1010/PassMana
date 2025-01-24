import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';

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
      borderRadius: BorderRadius.circular(3),
      child: Material(
        color: Theme.of(context).cardColor,
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
              borderRadius: BorderRadius.circular(3),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "${AppConstants.secretNoteHero}${secretNote.id}",
                  child: Text(
                    secretNote.note,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('dd/MM/yyyy HH:mm a').format(secretNote.lastUpdatedOn),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 13),
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
