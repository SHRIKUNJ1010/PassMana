/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/dropdown_search.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/menu_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/popup_props.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdatePasswordScreen extends StatefulWidget {
  final int? id;

  const CreateUpdatePasswordScreen({
    super.key,
    required this.id,
  });

  @override
  State<CreateUpdatePasswordScreen> createState() => _CreateUpdatePasswordScreenState();
}

class _CreateUpdatePasswordScreenState extends State<CreateUpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  Group? selectedGroup;

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdatePasswordViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdatePasswordViewModel.fromStore(store, widget.id);
      },
      onInit: (Store<AppState> store) {
        if (widget.id != null) {
          titleController.text = getPasswordById(store.state, widget.id)?.title ?? "";
          subTitleController.text = getPasswordById(store.state, widget.id)?.subTitle ?? "";
          userNameController.text = getPasswordById(store.state, widget.id)?.userName ?? "";
          passwordController.text = getPasswordById(store.state, widget.id)?.password ?? "";
          noteController.text = getPasswordById(store.state, widget.id)?.note ?? "";
          selectedGroup = getPasswordById(store.state, widget.id)?.group.target;
        }
      },
      builder: (BuildContext context, CreateUpdatePasswordViewModel vm) {
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
                            getTitleField(context, titleController),
                            getSubTitleField(context, subTitleController),
                            getUserNameField(context, userNameController),
                            getPasswordField(context, passwordController),
                            getNoteField(context, noteController),
                            getGroupSelectField(context, vm),
                            const SizedBox(height: 350),
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

  Column getGroupSelectField(BuildContext context, CreateUpdatePasswordViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('category_group')}:",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        DropdownSearch<Group?>(
          itemAsString: (item) => item?.groupName ?? "None",
          items: [null, ...vm.groupSelectOptionList],
          compareFn: (g1, g2) => g1?.id == g2?.id,
          selectedItem: selectedGroup,
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            containerBuilder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: child,
              );
            },
            itemBuilder: (context, item, isSelected) {
              if (isSelected) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: getSelectedPopupMenuItem(item),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: getNonSelectedPopupMenuItem(item),
                );
              }
            },
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(10),
              barrierLabel: getTranslated("groups"),
            ),
          ),
          onChanged: (item) {
            if (item != null) {
              selectedGroup = item;
            } else {
              selectedGroup = null;
            }
            setState(() {});
          },
          selectedItemBuilder: (item, onTap) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      onTap.call();
                    },
                    splashColor: AppColors.primaryColor.withOpacity(0.2),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              item?.groupName ?? "None",
                              style: TextStyles.getTitleBlueText(18),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Container getNonSelectedPopupMenuItem(Group? item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Text(
        item?.groupName ?? "None",
        style: TextStyles.getTitleBlueText(17),
      ),
    );
  }

  Container getSelectedPopupMenuItem(Group? item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
      child: Text(
        item?.groupName ?? "None",
        style: TextStyles.getTitleWhiteText(17),
      ),
    );
  }

  ClipRRect getCreateUpdateButton(CreateUpdatePasswordViewModel vm) {
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
                vm.updatePassword.call(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  userName: userNameController.text,
                  password: passwordController.text,
                  note: noteController.text,
                  targetGroup: selectedGroup,
                );
              } else {
                vm.createPassword.call(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  userName: userNameController.text,
                  password: passwordController.text,
                  note: noteController.text,
                  targetGroup: selectedGroup,
                );
              }
            }
          },
          child: Container(
            height: 65,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              vm.password != null ? getTranslated('update') : getTranslated('create'),
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
    );
  }

  Column getNoteField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('note')}: (${getTranslated('optional')})",
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

  //todo: add obscure option
  //todo: also think of some way to give option of generating password and assigning directly to this field
  Column getPasswordField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('password')}:",
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

  Column getUserNameField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('email_or_username')}:",
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

  Column getSubTitleField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('subtitle')}: (${getTranslated('optional')})",
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
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  Column getTitleField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "${getTranslated('title')}:",
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

  CustomAppBar getAppBar(CreateUpdatePasswordViewModel vm) {
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
          vm.password != null ? getTranslated("update_password") : getTranslated("create_password"),
          style: TextStyles.getTitleWhiteText(25),
        ),
        vm.password != null
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
