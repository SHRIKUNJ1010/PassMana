import 'package:flutter/material.dart';

typedef WidgetCheckBox = Widget Function(BuildContext context, bool isChecked);

class CheckBoxWidget extends StatefulWidget {
  final WidgetCheckBox? layout;
  final WidgetCheckBox? checkBox;
  final bool isChecked;
  final bool isDisabled;
  final ValueChanged<bool?>? onChanged;
  final bool interceptCallBacks;

  const CheckBoxWidget({
    super.key,
    this.isChecked = false,
    this.isDisabled = false,
    this.layout,
    this.checkBox,
    this.interceptCallBacks = false,
    required this.onChanged,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final ValueNotifier<bool> isCheckedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isCheckedNotifier.value = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant CheckBoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked != oldWidget.isChecked) {
      isCheckedNotifier.value = widget.isChecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isCheckedNotifier,
      builder: (ctx, bool v, w) {
        var w = Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.layout != null ? Expanded(child: widget.layout!(context, v == true)) : Container(),
            widget.checkBox != null ? widget.checkBox!(context, v == true) : Checkbox(value: v, onChanged: widget.isDisabled ? null : (b) {}),
          ],
        );

        if (widget.interceptCallBacks) {
          return w;
        } else {
          return InkWell(
            onTap: widget.isDisabled
                ? null
                : () {
                    isCheckedNotifier.value = !v;
                    if (widget.onChanged != null) widget.onChanged!(v);
                  },
            child: IgnorePointer(child: w),
          );
        }
      },
    );
  }
}
