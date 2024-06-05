import 'package:flutter/material.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/utility/color.dart';

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
          splashColor: AppColors.primaryColor.withOpacity(0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 120,
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
