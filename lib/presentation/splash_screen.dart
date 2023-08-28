/*
* Created by Shrikunj Patel on 8/24/2023.
*/
import 'package:flutter/material.dart';
import 'package:passmana/utility/assets_utility/image_paths.dart';
import 'package:passmana/utility/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      alignment: Alignment.center,
      child: Image.asset(appLogoWithText),
    );
  }
}
