/*
* Created by Shrikunj Patel on 11/28/2023.
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CustomPinField extends StatefulWidget {
  final Widget bottomLeftButtonChild;
  final Function(TextEditingController) onBottomLeftButtonTap;
  final Widget bottomRightButtonChild;
  final Function(TextEditingController) onBottomRightButtonTap;
  final Function(TextEditingController) onPinCompleted;
  final bool disableBottomLeft;
  final bool disableBottomRight;
  final String? errorText;

  const CustomPinField({
    super.key,
    required this.errorText,
    required this.disableBottomLeft,
    required this.disableBottomRight,
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
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Row(mainAxisSize: MainAxisSize.max),
          const Spacer(),
          CommonWidgets.getCommonHiddenPinField(controller: _pinController),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                widget.errorText!,
                style: TextStyles.getTitleOrangeText(20),
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CommonWidgets.getCommonNumericKeyboard(
              context: context,
              controller: _pinController,
              disableBottomLeft: widget.disableBottomLeft,
              disableBottomRight: widget.disableBottomRight,
              bottomLeftButtonChild: widget.bottomLeftButtonChild,
              bottomRightButtonChild: widget.bottomRightButtonChild,
              onBottomLeftButtonTap: () {
                widget.onBottomLeftButtonTap.call(_pinController);
              },
              onBottomRightButtonTap: () {
                widget.onBottomRightButtonTap.call(_pinController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
