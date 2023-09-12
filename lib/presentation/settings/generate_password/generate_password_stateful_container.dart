/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/presentation/settings/generate_password/generate_password_view_model.dart';

class GeneratePasswordStatefulContainer extends StatefulWidget {
  final GeneratePasswordViewModel vm;

  const GeneratePasswordStatefulContainer({
    super.key,
    required this.vm,
  });

  @override
  State<GeneratePasswordStatefulContainer> createState() => _GeneratePasswordStatefulContainerState();
}

class _GeneratePasswordStatefulContainerState extends State<GeneratePasswordStatefulContainer> {
  bool hasLowercase = true;
  bool hasUppercase = true;
  bool hasNumeric = true;
  bool hasSpecialCharacter = true;
  bool hasUmlauts = false;
  bool isReadable = false;
  int passwordLength = 20;

  @override
  Widget build(BuildContext context) {
    //todo: change
    return Container();
  }
}
