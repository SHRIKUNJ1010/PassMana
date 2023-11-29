/*
* Created by Shrikunj Patel on 11/28/2023.
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';

class CustomPinField extends StatefulWidget {
  final Widget bottomLeftButtonChild;
  final Function(TextEditingController) onBottomLeftButtonTap;
  final Widget bottomRightButtonChild;
  final Function(TextEditingController) onBottomRightButtonTap;
  final Function(TextEditingController) onPinCompleted;

  const CustomPinField({
    super.key,
    required this.bottomLeftButtonChild,
    required this.bottomRightButtonChild,
    required this.onBottomLeftButtonTap,
    required this.onBottomRightButtonTap,
    required this.onPinCompleted,
  });

  @override
  State<CustomPinField> createState() => _CustomPinFieldState();
}

class _CustomPinFieldState extends State<CustomPinField> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pinController.addListener(() {
        if (_pinController.text.length == 6) {
          widget.onPinCompleted.call(_pinController);
        }
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Row(mainAxisSize: MainAxisSize.max),
          const Spacer(),
          CommonWidgets.getCommonHiddenPinField(controller: _pinController),
          const Spacer(),
          CommonWidgets.getCommonNumericKeyboard(
            controller: _pinController,
            bottomLeftButtonChild: widget.bottomLeftButtonChild,
            bottomRightButtonChild: widget.bottomRightButtonChild,
            onBottomLeftButtonTap: () {
              widget.onBottomLeftButtonTap.call(_pinController);
            },
            onBottomRightButtonTap: () {
              widget.onBottomRightButtonTap.call(_pinController);
            },
          ),
        ],
      ),
    );
  }
}
