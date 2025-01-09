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
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_bottom_button.dart';
import 'package:passmana/presentation/common/common_text_field.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/dropdown_search.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/list_view_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/menu_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/popup_props.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_view_model.dart';
import 'package:passmana/presentation/password/create_update_password/password_dynamic_field_list_item_widget.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
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
                            getTitleField(context, titleController, vm.password?.id),
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
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
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
                                borderRadius: BorderRadius.circular(3),
                                child: Material(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(3),
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
                                          Icon(
                                            Icons.add,
                                            color: Theme.of(context).textTheme.headlineSmall?.color,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            getTranslated('add_field', context),
                                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
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
                    borderRadius: BorderRadius.circular(3),
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
                borderRadius: BorderRadius.circular(3),
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
                borderRadius: BorderRadius.circular(3),
                child: Material(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(3),
                  child: InkWell(
                    onTap: () {
                      onTap.call();
                    },
                    splashColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              item?.groupName ?? "None",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).textTheme.headlineSmall?.color,
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Text(
        item?.groupName ?? "None",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 17),
      ),
    );
  }

  Container getSelectedPopupMenuItem(Group? item) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
      child: Text(
        item?.groupName ?? "None",
        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
      ),
    );
  }

  Widget getCreateUpdateButton(CreateUpdatePasswordViewModel vm) {
    return CommonBottomButton(
      title: vm.password != null ? getTranslated('update', context) : getTranslated('create', context),
      onItemTap: () {
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("note", context),
            maxLines: 5,
            textInputAction: TextInputAction.done,
            isMandatory: false,
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Row(
            children: [
              Expanded(
                child: CommonTextField(
                  controller: controller,
                  hintText: getTranslated("password", context),
                  suffixIcon: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 25,
                    margin: const EdgeInsets.only(right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Material(
                        color: Theme.of(context).cardColor,
                        child: InkWell(
                          onTap: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          splashColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: showPassword
                                ? Icon(
                                    FontAwesome5.eye,
                                    color: Theme.of(context).textTheme.headlineSmall?.color,
                                    size: 17,
                                  )
                                : Icon(
                                    FontAwesome5.eye_slash,
                                    color: Theme.of(context).textTheme.headlineSmall?.color,
                                    size: 17,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  obscureText: !showPassword,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 10),
              CommonAppBarActionIconButton(
                onItemTap: () async {
                  String tempPassword = await Utility.generatePasswordDialog();
                  if (tempPassword.isNotEmpty) {
                    passwordController.text = tempPassword;
                    setState(() {});
                  }
                },
                iconPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                icon: Icon(
                  Icons.alt_route,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("email_or_username", context),
            textInputAction: TextInputAction.next,
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("subtitle", context),
            isMandatory: false,
            textInputAction: TextInputAction.next,
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("website_url", context),
            textInputAction: TextInputAction.next,
            isMandatory: false,
          ),
        ),
      ],
    );
  }

  Column getTitleField(BuildContext context, TextEditingController controller, int? passwordId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: passwordId != null
                  ? Hero(
                      tag: "${AppConstants.passwordHero}$passwordId",
                      child: Text(
                        "${getTranslated('title', context)}:",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                      ),
                    )
                  : Text(
                      "${getTranslated('title', context)}:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
                    ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: CommonTextField(
            controller: controller,
            hintText: getTranslated("title", context),
            textInputAction: TextInputAction.next,
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
        vm.password == null
            ? Hero(
                tag: AppConstants.passwordHero,
                child: Text(
                  getTranslated("create_password", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
                ),
              )
            : Text(
                getTranslated("update_password", context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
              ),
        vm.password != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAppBarActionIconButton(
                      onItemTap: () {
                        vm.deletePassword.call();
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
