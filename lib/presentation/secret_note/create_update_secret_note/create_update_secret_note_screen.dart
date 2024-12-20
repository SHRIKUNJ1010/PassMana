/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/secret_note/create_update_secret_note/create_update_secret_note_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdateSecretNoteScreen extends StatefulWidget {
  final int? id;

  const CreateUpdateSecretNoteScreen({
    super.key,
    required this.id,
  });

  @override
  State<CreateUpdateSecretNoteScreen> createState() => _CreateUpdateSecretNoteScreenState();
}

class _CreateUpdateSecretNoteScreenState extends State<CreateUpdateSecretNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateSecretNoteViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateSecretNoteViewModel.fromStore(store, widget.id);
      },
      onInit: (Store<AppState> store) {
        if (widget.id != null) {
          noteController.text = getSecretNoteById(store.state, widget.id)?.note ?? '';
        }
      },
      builder: (BuildContext context, CreateUpdateSecretNoteViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                //TODO: find a way to add loader while creating updating or deleting data for all create update screen
                //TODO: also add manual delay show that process can be shown that process does loads
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  appBar: getAppBar(vm, context),
                  body: getNoteField(context, noteController),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: getCreateUpdateButton(vm, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getNoteField(BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "${getTranslated('secret_note', context)}:",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mWhite,
            ),
            child: TextFormField(
              controller: controller,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return getTranslated("field_can't_be_empty", context);
                }
                return null;
              },
              style: TextStyles.getTitleBlueText(18),
              decoration: InputDecoration(
                hintText: getTranslated("write_your_note_here", context),
                hintStyle: TextStyles.getTitleBlueText(18),
                contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 1000,
              textInputAction: TextInputAction.done,
              onTapOutside: (pointerDown) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
      ],
    );
  }

  ClipRRect getCreateUpdateButton(CreateUpdateSecretNoteViewModel vm, BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: InkWell(
          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (widget.id != null) {
                vm.updateSecretNote.call(
                  note: noteController.text,
                );
              } else {
                vm.createSecretNote.call(
                  note: noteController.text,
                );
              }
            }
          },
          child: Container(
            height: 65 + MediaQuery.paddingOf(context).bottom,
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              vm.secretNote != null ? getTranslated('update', context) : getTranslated('create', context),
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar getAppBar(CreateUpdateSecretNoteViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
                    onTap: () {
                      vm.onBackPress.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          vm.secretNote != null ? getTranslated("update_secret_note", context) : getTranslated("create_secret_note", context),
          style: TextStyles.getTitleWhiteText(24),
        ),
        vm.secretNote != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: AppColors.secondaryMaterialColor[700],
                        child: InkWell(
                          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                          onTap: () {
                            vm.deleteSecretNote.call();
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.mWhite,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            : const Spacer(),
      ],
    );
  }
}
