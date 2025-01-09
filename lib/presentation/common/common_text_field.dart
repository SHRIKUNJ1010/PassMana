/*
Created By Shrikunj on 07/01/25
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final bool isMandatory;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? fieldValidator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool showMaxLengthLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final Function(String)? onChanged;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.isMandatory = true,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.fieldValidator,
    this.inputFormatters,
    this.maxLines,
    this.maxLength,
    this.readOnly = false,
    this.showMaxLengthLabel = false,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (text) {
        if (isMandatory && (text == null || text.isEmpty)) {
          return getTranslated("field_can't_be_empty", context);
        }
        if (fieldValidator != null) return fieldValidator?.call(text);
        return null;
      },
      onChanged: onChanged,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
      initialValue: initialValue,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
        errorStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 20,
              color: AppColors.mFF9C00,
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(3),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      buildCounter: showMaxLengthLabel
          ? null
          : (context, {required currentLength, required isFocused, required maxLength}) {
              return const SizedBox.shrink();
            },
      onTapOutside: (pointerDown) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
