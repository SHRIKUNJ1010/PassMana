import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/clear_button_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/properties/popup_props.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/widgets/popupMenu.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/src/widgets/selection_widget.dart';
import 'package:passmana/utility/enum_types.dart';

typedef DropdownSearchOnFind<T> = Future<List<T>> Function(String text);
typedef DropdownSearchItemAsString<T> = String Function(T item);
typedef DropdownSearchFilterFn<T> = bool Function(T item, String filter);
typedef DropdownSearchCompareFn<T> = bool Function(T item1, T item2);
typedef DropdownSearchBuilder<T> = Widget Function(BuildContext context, T? selectedItem);
typedef DropdownSearchBuilderMultiSelection<T> = Widget Function(
  BuildContext context,
  List<T> selectedItems,
);
typedef DropdownSearchPopupItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef DropdownSearchPopupItemEnabled<T> = bool Function(T item);
typedef ErrorBuilder<T> = Widget Function(
  BuildContext context,
  String searchEntry,
  dynamic exception,
);
typedef EmptyBuilder<T> = Widget Function(BuildContext context, String searchEntry);
typedef LoadingBuilder<T> = Widget Function(BuildContext context, String searchEntry);
typedef BeforeChange<T> = Future<bool?> Function(T? prevItem, T? nextItem);
typedef BeforePopupOpening<T> = Future<bool?> Function(T? selectedItem);
typedef BeforePopupOpeningMultiSelection<T> = Future<bool?> Function(List<T> selItems);
typedef BeforeChangeMultiSelection<T> = Future<bool?> Function(
  List<T> prevItems,
  List<T> nextItems,
);
typedef FavoriteItemsBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef ValidationMultiSelectionBuilder<T> = Widget Function(
  BuildContext context,
  List<T> item,
);

typedef PositionCallback = RelativeRect Function(
  RenderBox popupButtonObject,
  RenderBox overlay,
);

typedef OnItemAdded<T> = void Function(List<T> selectedItems, T addedItem);
typedef OnItemRemoved<T> = void Function(List<T> selectedItems, T removedItem);
typedef PopupBuilder = Widget Function(BuildContext context, Widget popupWidget);

///[items] are the original item from [items] or/and [asyncItems]
typedef FavoriteItems<T> = List<T> Function(List<T> items);

class DropdownSearch<T> extends StatefulWidget {
  //display item builder
  final Widget Function(T? item, Function onTap) selectedItemBuilder;

  ///offline items list
  final List<T> items;

  ///selected item
  final T? selectedItem;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? asyncItems;

  ///called when a new item is selected
  final ValueChanged<T?>? onChanged;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///enable/disable dropdownSearch
  final bool enabled;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  /// Used to configure the auto validation of [FormField] and [Form] widgets.
  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<T>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<T>? validator;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  ///custom dropdown clear button icon properties
  final ClearButtonProps clearButtonProps;

  ///a callBack will be called before opening le popup
  ///if the callBack return FALSE, the opening of the popup will be cancelled
  final BeforePopupOpening<T>? onBeforePopupOpening;

  ///custom props to single mode popup
  final PopupPropsMultiSelection<T> popupProps;

  DropdownSearch({
    Key? key,
    this.onSaved,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.items = const [],
    this.selectedItem,
    this.asyncItems,
    this.dropdownBuilder,
    this.clearButtonProps = const ClearButtonProps(),
    this.enabled = true,
    this.filterFn,
    this.itemAsString,
    this.compareFn,
    this.onBeforeChange,
    this.onBeforePopupOpening,
    PopupProps<T> popupProps = const PopupProps.menu(),
    required this.selectedItemBuilder,
  })  : assert(
          !popupProps.showSelectedItems || T == String || compareFn != null,
        ),
        popupProps = PopupPropsMultiSelection.from(popupProps),
        super(key: key);

  @override
  DropdownSearchState<T> createState() => DropdownSearchState<T>();
}

class DropdownSearchState<T> extends State<DropdownSearch<T>> {
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final _popupStateKey = GlobalKey<SelectionWidgetState<T>>();

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = _itemToList(widget.selectedItem);
  }

  @override
  void didUpdateWidget(DropdownSearch<T> oldWidget) {
    List<T> oldSelectedItems = _itemToList(oldWidget.selectedItem);

    List<T> newSelectedItems = _itemToList(widget.selectedItem);

    if (!listEquals(oldSelectedItems, newSelectedItems)) {
      _selectedItemsNotifier.value = List.from(newSelectedItems);
    }

    ///this code check if we need to refresh the popup widget to update
    ///containerBuilder widget
    if (widget.popupProps.containerBuilder != oldWidget.popupProps.containerBuilder) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _popupStateKey.currentState?.setState(() {});
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T?>>(
      valueListenable: _selectedItemsNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: widget.selectedItemBuilder.call(
            _selectedItemsNotifier.value.isEmpty ? null : _selectedItemsNotifier.value.first,
            () => _selectSearchMode(),
          ),
        );
      },
    );
  }

  List<T> _itemToList(T? item) {
    List<T?> nullableList = List.filled(1, item);
    return nullableList.whereType<T>().toList();
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay),
        popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

  ///open dialog
  Future _openSelectDialog() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: widget.popupProps.dialogProps.barrierDismissible,
      barrierLabel: widget.popupProps.dialogProps.barrierLabel,
      transitionDuration: widget.popupProps.dialogProps.transitionDuration,
      barrierColor: widget.popupProps.dialogProps.barrierColor ?? Colors.black54,
      useRootNavigator: widget.popupProps.dialogProps.useRootNavigator,
      anchorPoint: widget.popupProps.dialogProps.anchorPoint,
      transitionBuilder: widget.popupProps.dialogProps.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          buttonPadding: widget.popupProps.dialogProps.buttonPadding,
          actionsOverflowButtonSpacing: widget.popupProps.dialogProps.actionsOverflowButtonSpacing,
          insetPadding: widget.popupProps.dialogProps.insetPadding,
          actionsPadding: widget.popupProps.dialogProps.actionsPadding,
          actionsOverflowDirection: widget.popupProps.dialogProps.actionsOverflowDirection,
          actionsOverflowAlignment: widget.popupProps.dialogProps.actionsOverflowAlignment,
          actionsAlignment: widget.popupProps.dialogProps.actionsAlignment,
          actions: widget.popupProps.dialogProps.actions,
          alignment: widget.popupProps.dialogProps.alignment,
          clipBehavior: widget.popupProps.dialogProps.clipBehavior,
          elevation: widget.popupProps.dialogProps.elevation,
          contentPadding: widget.popupProps.dialogProps.contentPadding,
          shape: widget.popupProps.dialogProps.shape,
          backgroundColor: widget.popupProps.dialogProps.backgroundColor,
          semanticLabel: widget.popupProps.dialogProps.semanticLabel,
          content: _popupWidgetInstance(),
        );
      },
    );
  }

  Future _openBottomSheet() {
    return showBottomSheet(
        context: context,
        enableDrag: widget.popupProps.bottomSheetProps.enableDrag,
        backgroundColor: widget.popupProps.bottomSheetProps.backgroundColor,
        clipBehavior: widget.popupProps.bottomSheetProps.clipBehavior,
        elevation: widget.popupProps.bottomSheetProps.elevation,
        shape: widget.popupProps.bottomSheetProps.shape,
        transitionAnimationController: widget.popupProps.bottomSheetProps.animation,
        constraints: widget.popupProps.bottomSheetProps.constraints,
        builder: (ctx) {
          return _popupWidgetInstance();
        }).closed;
  }

  ///open BottomSheet (Dialog mode)
  Future _openModalBottomSheet() {
    final sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
        context: context,
        barrierColor: widget.popupProps.modalBottomSheetProps.barrierColor,
        backgroundColor:
            widget.popupProps.modalBottomSheetProps.backgroundColor ?? sheetTheme.modalBackgroundColor ?? sheetTheme.backgroundColor ?? Colors.white,
        isDismissible: widget.popupProps.modalBottomSheetProps.barrierDismissible,
        isScrollControlled: widget.popupProps.modalBottomSheetProps.isScrollControlled,
        enableDrag: widget.popupProps.modalBottomSheetProps.enableDrag,
        clipBehavior: widget.popupProps.modalBottomSheetProps.clipBehavior,
        elevation: widget.popupProps.modalBottomSheetProps.elevation,
        shape: widget.popupProps.modalBottomSheetProps.shape,
        anchorPoint: widget.popupProps.modalBottomSheetProps.anchorPoint,
        useRootNavigator: widget.popupProps.modalBottomSheetProps.useRootNavigator,
        transitionAnimationController: widget.popupProps.modalBottomSheetProps.animation,
        constraints: widget.popupProps.modalBottomSheetProps.constraints,
        builder: (ctx) {
          final viewInsetsBottom = EdgeInsets.fromViewPadding(
            View.of(context).viewInsets,
            View.of(context).devicePixelRatio,
          ).bottom;

          final viewPaddingTop = EdgeInsets.fromViewPadding(
            View.of(context).padding,
            View.of(context).devicePixelRatio,
          ).top;

          return Container(
            margin: EdgeInsets.only(
              bottom: viewInsetsBottom,
              top: viewPaddingTop,
            ),
            child: _popupWidgetInstance(),
          );
        });
  }

  ///openMenu
  Future _openMenu() {
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showCustomMenu<T>(
      menuModeProps: widget.popupProps.menuProps,
      context: context,
      position: (widget.popupProps.menuProps.positionCallback ?? _position)(
        popupButtonObject,
        overlay,
      ),
      child: _popupWidgetInstance(),
    );
  }

  Widget _popupWidgetInstance() {
    return SelectionWidget<T>(
      key: _popupStateKey,
      popupProps: widget.popupProps,
      itemAsString: widget.itemAsString,
      filterFn: widget.filterFn,
      items: widget.items,
      asyncItems: widget.asyncItems,
      onChanged: _handleOnChangeSelectedItems,
      compareFn: widget.compareFn,
      isMultiSelectionMode: false,
      defaultSelectedItems: List.from(getSelectedItems),
    );
  }

  ///Function that manage focus listener
  ///set true only if the widget already not focused to prevent unnecessary build
  ///same thing for clear focus,
  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  ///handle on change value , if the validation is active , we validate the new selected item
  void _handleOnChangeSelectedItems(List<T> selectedItems) {
    changeItem() {
      _selectedItemsNotifier.value = List.from(selectedItems);
      if (widget.onChanged != null) {
        widget.onChanged!(getSelectedItem);
      }
    }

    if (widget.onBeforeChange != null) {
      widget.onBeforeChange!(getSelectedItem, selectedItems.isEmpty ? null : selectedItems.first).then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else {
      changeItem();
    }

    _handleFocus(false);
  }

  ///compared two items base on user params
  bool _isEqual(T i1, T i2) {
    if (widget.compareFn != null) {
      return widget.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  ///Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  Future<void> _selectSearchMode() async {
    //handle onBefore popupOpening
    if (widget.onBeforePopupOpening != null) {
      if (await widget.onBeforePopupOpening!(getSelectedItem) == false) return;
    }

    _handleFocus(true);
    if (widget.popupProps.mode == Mode.menu) {
      await _openMenu();
    } else if (widget.popupProps.mode == Mode.modalBottomSheet) {
      await _openModalBottomSheet();
    } else if (widget.popupProps.mode == Mode.bottomSheet) {
      await _openBottomSheet();
    } else {
      await _openSelectDialog();
    }
    //dismiss either by selecting items OR clicking outside the popup
    _handleFocus(false);
  }

  ///Change selected Value; this function is public USED to change the selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  ///for multiSelection mode you can use [changeSelectedItems]
  void changeSelectedItem(T? selectedItem) => _handleOnChangeSelectedItems(_itemToList(selectedItem));

  ///Change selected Value; this function is public USED to change the selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  ///for SingleSelection mode you can use [changeSelectedItem]
  void changeSelectedItems(List<T> selectedItems) => _handleOnChangeSelectedItems(selectedItems);

  ///function to remove an item from the list
  ///Useful i multiSelection mode to delete an item
  void removeItem(T itemToRemove) => _handleOnChangeSelectedItems(getSelectedItems..removeWhere((i) => _isEqual(itemToRemove, i)));

  ///Change selected Value; this function is public USED to clear selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  void clear() => _handleOnChangeSelectedItems([]);

  ///get selected value programmatically USED for SINGLE_SELECTION mode
  T? get getSelectedItem => getSelectedItems.isEmpty ? null : getSelectedItems.first;

  ///get selected values programmatically
  List<T> get getSelectedItems => _selectedItemsNotifier.value;

  ///check if the dropdownSearch is focused
  bool get isFocused => _isFocused.value;

  ///select items programmatically on the popup of selection
  void popupSelectItems(List<T> itemsToSelect) {
    _popupStateKey.currentState?.selectItems(itemsToSelect);
  }

  ///validate selected items programmatically on the popup of selection
  void popupOnValidate() {
    _popupStateKey.currentState?.onValidate();
  }

  ///validate selected items programmatically passed in param [itemsToValidate]
  void popupValidate(List<T> itemsToValidate) {
    closeDropDownSearch();
    changeSelectedItems(itemsToValidate);
  }

  ///Public Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  ///THIS USED FOR OPEN DROPDOWN_SEARCH PROGRAMMATICALLY,
  ///otherwise you can you [_selectSearchMode]
  void openDropDownSearch() => _selectSearchMode();

  ///close dropdownSearch popup if it's open
  void closeDropDownSearch() => _popupStateKey.currentState?.closePopup();

  ///returns true if all popup's items are selected; other wise False
  bool get popupIsAllItemSelected => _popupStateKey.currentState?.isAllItemSelected ?? false;

  ///returns popup selected items
  List<T> get popupGetSelectedItems => _popupStateKey.currentState?.getSelectedItem ?? [];

  void updatePopupState() => _popupStateKey.currentState?.setState(() {});
}
