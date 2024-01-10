/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/group/create_update_group/create_update_group_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdateGroupScreen extends StatefulWidget {
  final int? id;

  const CreateUpdateGroupScreen({
    super.key,
    required this.id,
  });

  @override
  State<CreateUpdateGroupScreen> createState() => _CreateUpdateGroupScreenState();
}

class _CreateUpdateGroupScreenState extends State<CreateUpdateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdateGroupViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdateGroupViewModel.fromStore(store, widget.id);
      },
      onInit: (Store<AppState> store) {
        if (widget.id != null) {
          groupNameController.text = getGroupById(store.state, widget.id)?.groupName ?? "";
          descriptionController.text = getGroupById(store.state, widget.id)?.description ?? "";
        }
      },
      builder: (BuildContext context, CreateUpdateGroupViewModel vm) {
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
                  appBar: getAppBar(vm),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            //todo: add next button for text field and focus on next field by using it
                            getGroupNameField(context, groupNameController),
                            getDescriptionField(context, descriptionController),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: getCreateUpdateButton(vm),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column getGroupNameField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('group_name')}:",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: TextFormField(
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return getTranslated("field_can't_be_empty");
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  Column getDescriptionField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('description')}: (${getTranslated('optional')})",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: TextFormField(
            controller: controller,
            validator: (text) => null,
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 5,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  ClipRRect getCreateUpdateButton(CreateUpdateGroupViewModel vm) {
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
          splashColor: AppColors.mWhite.withOpacity(0.2),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (widget.id != null) {
                vm.updateGroup.call(
                  groupName: groupNameController.text,
                  description: descriptionController.text,
                );
              } else {
                vm.createGroup.call(
                  groupName: groupNameController.text,
                  description: descriptionController.text,
                );
              }
            }
          },
          child: Container(
            height: 65,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              vm.group != null ? getTranslated('update') : getTranslated('create'),
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar getAppBar(CreateUpdateGroupViewModel vm) {
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
                    splashColor: AppColors.mBlack.withOpacity(0.2),
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
          vm.group != null ? getTranslated("update_group") : getTranslated("create_group"),
          style: TextStyles.getTitleWhiteText(25),
        ),
        vm.group != null
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
                          splashColor: AppColors.mWhite.withOpacity(0.2),
                          onTap: () {
                            //todo: on delete method
                            //vm.onBackPress.call();
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
