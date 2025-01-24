/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/secret_note/secret_note_list/secret_note_list_view_model.dart';
import 'package:passmana/presentation/secret_note/secret_note_list/widgets/secret_note_common_list_tile.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';

class SecretNoteListScreen extends StatelessWidget {
  const SecretNoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SecretNoteListViewModel>(
      converter: SecretNoteListViewModel.fromStore,
      builder: (BuildContext context, SecretNoteListViewModel vm) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              centerWidgetsList: [
                const SizedBox(width: 20),
                SizedBox(
                  width: 40,
                  child: Hero(
                    tag: AppConstants.appLogo,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(AppAssets.appLogoWithoutText),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  getTranslated("secret_note", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28),
                ),
                const Spacer(),
              ],
            ),
            body: SafeArea(
              child: vm.secretNoteList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      child: SizedBox(
                        width: width - 40,
                        child: Center(
                          child: Text(
                            getTranslated('no_secret_note_found', context),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                      shrinkWrap: true,
                      itemCount: vm.secretNoteList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: SecretNoteCommonListTile(
                            secretNote: vm.secretNoteList[index],
                            onTap: () {
                              vm.onSecretNoteTileTap.call(vm.secretNoteList[index].id);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
