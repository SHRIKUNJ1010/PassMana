/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/dropdown_search.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/list_view_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/menu_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/popup_props.dart';
import 'package:passmana/presentation/settings/settings_item_list/settings_item_list_view_model.dart';
import 'package:passmana/presentation/settings/settings_item_list/settings_item_text_button_tile.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';

class SettingsItemListScreen extends StatelessWidget {
  const SettingsItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsItemListViewModel>(
      converter: SettingsItemListViewModel.fromStore,
      builder: (BuildContext context, SettingsItemListViewModel vm) {
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
                  getTranslated("settings", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28),
                ),
                const Spacer(),
              ],
            ),
            body: ListView(
              children: [
                const SizedBox(height: 20),
                //TODO: add when autofill is available
                /*Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.mWhite,
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("enable_autofill", context),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize:20),
                        ),
                      ),
                      Switch(
                        value: vm.isAutofillEnabled,
                        onChanged: (val) {
                          vm.onChangeAutofill.call(val);
                        },
                      ),
                    ],
                  ),
                ),*/
                getCommonContainer(
                  context: context,
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("enable_biometric", context),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                        ),
                      ),
                      Switch(
                        value: vm.isBiometricEnabled,
                        onChanged: (val) {
                          vm.onChangeBiometric.call(val);
                        },
                      ),
                    ],
                  ),
                ),
                getCommonContainer(
                  context: context,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("language", context),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                        ),
                      ),
                      DropdownSearch<Locale>(
                        itemAsString: (item) => Utility.getLanguageNameFromLanguageCode(item.languageCode),
                        items: const [
                          Locale(AppConstants.english),
                          Locale(AppConstants.gujarati),
                          Locale(AppConstants.hindi),
                        ],
                        compareFn: (g1, g2) => g1.languageCode == g2.languageCode,
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
                                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: getSelectedPopupMenuItem(item, context),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: getNonSelectedPopupMenuItem(item, context),
                              );
                            }
                          },
                          menuProps: MenuProps(
                            borderRadius: BorderRadius.circular(10),
                            barrierLabel: getTranslated("language", context),
                          ),
                        ),
                        onChanged: (item) {
                          if (item != null) {
                            vm.onChangeLocaleTap.call(item);
                          }
                        },
                        selectedItem: vm.selectedLanguage,
                        selectedItemBuilder: (item, onTap) {
                          return SizedBox(
                            width: 110,
                            child: Material(
                              color: Theme.of(context).cardColor,
                              child: InkWell(
                                onTap: () {
                                  onTap.call();
                                },
                                splashColor: AppColors.secondaryColor.withValues(alpha: 0.2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColors.primaryColor),
                                    color: Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 4, 3, 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          Utility.getLanguageNameFromLanguageCode(item?.languageCode ?? AppConstants.english),
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: SettingsItemTextButtonTile(
                    title: getTranslated("change_mobile_pin", context),
                    onTap: () {
                      vm.onChangeMobilePinTap.call();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: SettingsItemTextButtonTile(
                    title: getTranslated("import_your_data", context),
                    onTap: () {
                      vm.onImportMobileDataTap.call();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: SettingsItemTextButtonTile(
                    title: getTranslated("export_your_data", context),
                    onTap: () {
                      vm.onExportMobileDataTap.call();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container getNonSelectedPopupMenuItem(Locale item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Text(
        Utility.getLanguageNameFromLanguageCode(item.languageCode),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
      ),
    );
  }

  Container getSelectedPopupMenuItem(Locale item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Text(
        Utility.getLanguageNameFromLanguageCode(item.languageCode),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
      ),
    );
  }

  Container getCommonContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Theme.of(context).cardColor,
      ),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: padding ?? const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: child,
    );
  }
}
