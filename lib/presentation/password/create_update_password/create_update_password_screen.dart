/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_dynamic_field_model.dart';
import 'package:passmana/model/screen_argument_models/create_update_password_screen_arguments.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/dropdown_search.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/list_view_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/menu_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/popup_props.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_view_model.dart';
import 'package:passmana/presentation/password/create_update_password/password_dynamic_field_list_item_widget.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdatePasswordScreen extends StatefulWidget {
  final CreateUpdatePasswordScreenArguments argument;

  const CreateUpdatePasswordScreen({
    super.key,
    required this.argument,
  });

  @override
  State<CreateUpdatePasswordScreen> createState() => _CreateUpdatePasswordScreenState();
}

class _CreateUpdatePasswordScreenState extends State<CreateUpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController websiteUrlController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  Group? selectedGroup;
  bool showPassword = false;
  List<PasswordDynamicField> dynamicFieldList = [];

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    websiteUrlController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateUpdatePasswordViewModel>(
      converter: (Store<AppState> store) {
        return CreateUpdatePasswordViewModel.fromStore(store, widget.argument.id);
      },
      onInit: (Store<AppState> store) {
        if (widget.argument.id != null) {
          List<PasswordDynamicField> tempDynamicList = [];
          try {
            tempDynamicList = PasswordDynamicFieldList.fromJson(
                  jsonDecode(
                    getPasswordById(store.state, widget.argument.id)?.dynamicDataField ?? "{}",
                  ),
                ).dynamicField ??
                [];
          } catch (e) {
            tempDynamicList = [];
          }
          if (tempDynamicList.isEmpty) {
            tempDynamicList.add(PasswordDynamicField());
          }
          titleController.text = getPasswordById(store.state, widget.argument.id)?.title ?? "";
          subTitleController.text = getPasswordById(store.state, widget.argument.id)?.subTitle ?? "";
          websiteUrlController.text = getPasswordById(store.state, widget.argument.id)?.websiteUrl ?? "";
          userNameController.text = getPasswordById(store.state, widget.argument.id)?.userName ?? "";
          passwordController.text = getPasswordById(store.state, widget.argument.id)?.password ?? "";
          noteController.text = getPasswordById(store.state, widget.argument.id)?.note ?? "";
          selectedGroup = getPasswordById(store.state, widget.argument.id)?.group.target;
          dynamicFieldList = tempDynamicList;
        } else {
          if (widget.argument.generatedPassword != null) {
            passwordController.text = widget.argument.generatedPassword ?? "";
          }
          dynamicFieldList = [PasswordDynamicField()];
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
                            getTitleField(context, titleController),
                            getSubTitleField(context, subTitleController),
                            getWebsiteUrlField(context, websiteUrlController),
                            getUserNameField(context, userNameController),
                            getPasswordField(context, passwordController),
                            getNoteField(context, noteController),
                            getGroupSelectField(context, vm),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                                  child: Text(
                                    "${getTranslated('custom_fields', context)}: (${getTranslated('optional', context)})",
                                    style: TextStyles.getTitleWhiteText(20),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemCount: dynamicFieldList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: PasswordDynamicFieldListItemWidget(
                                    key: ValueKey(dynamicFieldList[index].hashCode),
                                    item: dynamicFieldList[index],
                                    onCancelTap: () {
                                      if (dynamicFieldList.length != 1) {
                                        dynamicFieldList.removeAt(index);
                                        setState(() {});
                                      } else {
                                        //do nothing
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Material(
                                  color: AppColors.mWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 45,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        dynamicFieldList.add(PasswordDynamicField());
                                        setState(() {});
                                      },
                                      splashColor: AppColors.primaryColor.withValues(alpha: 0.3),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: AppColors.primaryColor,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            getTranslated('add_field', context),
                                            style: TextStyles.getTitleBlueText(18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                "${getTranslated('category_group', context)}: (${getTranslated('optional', context)})",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: DropdownSearch<Group?>(
            itemAsString: (item) => item?.groupName ?? "None",
            items: [null, ...vm.groupSelectOptionList],
            compareFn: (g1, g2) => g1?.id == g2?.id,
            selectedItem: selectedGroup,
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              listViewProps: const ListViewProps(shrinkWrap: true),
              containerBuilder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
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
                barrierLabel: getTranslated("groups", context),
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
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      onTap.call();
                    },
                    splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
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
              );
            },
          ),
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
          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (widget.argument.id != null) {
                vm.updatePassword.call(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  websiteUrl: websiteUrlController.text,
                  userName: userNameController.text,
                  password: passwordController.text,
                  note: noteController.text,
                  targetGroup: selectedGroup,
                  dynamicDataField: jsonEncode(PasswordDynamicFieldList(dynamicField: dynamicFieldList).toJson()),
                );
              } else {
                vm.createPassword.call(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  websiteUrl: websiteUrlController.text,
                  userName: userNameController.text,
                  password: passwordController.text,
                  note: noteController.text,
                  targetGroup: selectedGroup,
                  dynamicDataField: jsonEncode(PasswordDynamicFieldList(dynamicField: dynamicFieldList).toJson()),
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
              vm.password != null ? getTranslated('update', context) : getTranslated('create', context),
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
                "${getTranslated('note', context)}: (${getTranslated('optional', context)})",
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
              hintText: getTranslated("note", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 5,
            textInputAction: TextInputAction.done,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  Column getPasswordField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('password', context)}:",
                style: TextStyles.getTitleWhiteText(20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Row(
            children: [
              Expanded(
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
                    fillColor: AppColors.mWhite,
                    filled: true,
                    hintText: getTranslated("password", context),
                    hintStyle: TextStyles.getTitleBlueText(18),
                    contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                    errorStyle: TextStyles.getTitleOrangeText(20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      margin: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Material(
                          color: AppColors.mWhite,
                          child: InkWell(
                            onTap: () {
                              showPassword = !showPassword;
                              setState(() {});
                            },
                            splashColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: showPassword
                                  ? const Icon(
                                      FontAwesome5.eye,
                                      color: AppColors.primaryColor,
                                      size: 17,
                                    )
                                  : const Icon(
                                      FontAwesome5.eye_slash,
                                      color: AppColors.primaryColor,
                                      size: 17,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  obscureText: !showPassword,
                  textInputAction: TextInputAction.next,
                  onTapOutside: (pointerDown) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
                    onTap: () async {
                      String tempPassword = await Utility.generatePasswordDialog();
                      if (tempPassword.isNotEmpty) {
                        passwordController.text = tempPassword;
                        setState(() {});
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Icon(
                        Icons.alt_route,
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
                "${getTranslated('email_or_username', context)}:",
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
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("email_or_username", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
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
                "${getTranslated('subtitle', context)}: (${getTranslated('optional', context)})",
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
              hintText: getTranslated("subtitle", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
            onTapOutside: (pointerDown) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  Column getWebsiteUrlField(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "${getTranslated('website_url', context)}: (${getTranslated('optional', context)})",
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
              hintText: getTranslated("website_url", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
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
                "${getTranslated('title', context)}:",
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
                return getTranslated("field_can't_be_empty", context);
              }
              return null;
            },
            style: TextStyles.getTitleBlueText(18),
            decoration: InputDecoration(
              fillColor: AppColors.mWhite,
              filled: true,
              hintText: getTranslated("title", context),
              hintStyle: TextStyles.getTitleBlueText(18),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              errorStyle: TextStyles.getTitleOrangeText(20),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textInputAction: TextInputAction.next,
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
          vm.password != null ? getTranslated("update_password", context) : getTranslated("create_password", context),
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
                          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                          onTap: () {
                            vm.deletePassword.call();
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
