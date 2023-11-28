/*
* Created by Shrikunj Patel on 11/28/2023.
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';

class CustomPinField extends StatefulWidget {
  final Widget backButtonChild;
  final Function(TextEditingController) onBackTap;
  final Function(TextEditingController) onForwardTap;

  const CustomPinField({
    super.key,
    required this.backButtonChild,
    required this.onBackTap,
    required this.onForwardTap,
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
          widget.onForwardTap.call(_pinController);
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
            backButtonChild: widget.backButtonChild,
            onBackTap: () {
              widget.onBackTap.call(_pinController);
            },
          ),
        ],
      ),
    );
  }
}
