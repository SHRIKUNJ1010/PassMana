/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_bottom_button.dart';
import 'package:passmana/presentation/common/common_text_field.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/group/create_update_group/create_update_group_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
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
                  appBar: getAppBar(vm, context),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            getGroupNameField(context, groupNameController, vm.group?.id),
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
                  child: getCreateUpdateButton(vm, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column getGroupNameField(BuildContext context, TextEditingController controller, int? groupId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: groupId != null
                  ? Hero(
                      tag: "${AppConstants.groupHero}$groupId",
                      child: Text(
                        "${getTranslated('group_name', context)}:",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                      ),
                    )
                  : Text(
                      "${getTranslated('group_name', context)}:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                    ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("group_name", context),
            textInputAction: TextInputAction.next,
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
                "${getTranslated('description', context)}: (${getTranslated('optional', context)})",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("description", context),
            textInputAction: TextInputAction.done,
            isMandatory: false,
            maxLines: 5,
          ),
        ),
      ],
    );
  }

  Widget getCreateUpdateButton(CreateUpdateGroupViewModel vm, BuildContext context) {
    return CommonBottomButton(
      title: vm.group != null ? getTranslated('update', context) : getTranslated('create', context),
      onItemTap: () {
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
    );
  }

  CustomAppBar getAppBar(CreateUpdateGroupViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              CommonAppBarActionIconButton(
                onItemTap: () {
                  vm.onBackPress.call();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        vm.group == null
            ? Hero(
                tag: AppConstants.groupHero,
                child: Text(
                  getTranslated("create_group", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
                ),
              )
            : Text(
                getTranslated("update_group", context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
              ),
        vm.group != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAppBarActionIconButton(
                      onItemTap: () {
                        vm.deleteGroup.call();
                      },
                      buttonColor: Theme.of(context).textTheme.displayLarge?.color,
                      buttonSplashColor: AppColors.mWhite.withValues(alpha: 0.2),
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.mWhite,
                        size: 25,
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
