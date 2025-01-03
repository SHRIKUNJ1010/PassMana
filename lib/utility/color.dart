/*
* Created by Shrikunj Patel on 8/23/2023.
*/
import 'package:flutter/material.dart';

class AppColors {
  //background gradient color 1
  static const Color tem1 = Color(0xffD6E0FF);
  static const Color rem1 = Color(0xff1A1A2E);

  //background gradient color 2
  static const Color tem2 = Color(0xffFDB7FF);
  static const Color rem2 = Color(0xff3C1053);

  //home screen hello user text color
  static const Color tem3 = Color(0xffFF4A4A);
  static const Color rem3 = Color(0xffFF8585);

  //white text on home screen
  static const Color tem4 = Color(0xffFFFFFF);
  static const Color rem4 = Color(0xffE0E0E0);

  //white background in group card also for password card
  static const Color tem5 = Color(0xffFFFFFF);
  static const Color rem5 = Color(0xff2B2B2B);

  //popular group icon background color
  static const Color tem6 = Color(0xffC70039);
  static const Color rem6 = Color(0xffFF4A4A);

  //search bar background color
  static const Color tem7 = Color(0xffFFFFFF);
  static const Color rem7 = Color(0xff2E2E2E);

  //search bar text color
  static const Color tem8 = Color(0xff000000);
  static const Color rem8 = Color(0xffE0E0E0);

  //search icon background color
  static const Color tem9 = Color(0xffC70039);
  static const Color rem9 = Color(0xff4CC9F0);

  //bottom navigation bar background color
  static const Color tem10 = Color(0xff003F5C);
  static const Color rem10 = Color(0xff1A1A2E);

  //bottom navigation bar icon color (active/inactive need to figure out)
  static const Color tem11 = Color(0xffFFFFFF);
  static const Color rem11 = Color(0xff4CC9F0);

  //==============================primary color======================//
  static const MaterialColor primaryMaterialColor = MaterialColor(
    primaryColorValue,
    <int, Color>{
      50: Color(0xFFE4E9ED),
      100: Color(0xFFBCC8D3),
      200: Color(0xFF90A4B6),
      300: Color(0xFF637F98),
      400: Color(0xFF416382),
      500: Color(primaryColorValue),
      600: Color(0xFF1C4164),
      700: Color(0xFF183859),
      800: Color(0xFF13304F),
      900: Color(0xFF0B213D),
    },
  );

  static const MaterialColor accentPrimary = MaterialColor(
    accentPrimaryValue,
    <int, Color>{
      100: Color(0xFF76ACFF),
      200: Color(accentPrimaryValue),
      400: Color(0xFF106DFF),
      700: Color(0xFF0060F6),
    },
  );
  static const int accentPrimaryValue = 0xFF438CFF;
  static const Color accentPrimaryColor = Color(0xFF438CFF);

  static const int primaryColorValue = 0xFF20486C;
  static const Color primaryColor = Color(0xFF20486C);

//==============================secondary color======================//
  static const MaterialColor secondaryMaterialColor = MaterialColor(secondaryColorValue, <int, Color>{
    50: Color(0xFFF5E5E9),
    100: Color(0xFFE6BDC9),
    200: Color(0xFFD692A5),
    300: Color(0xFFC56681),
    400: Color(0xFFB84566),
    500: Color(secondaryColorValue),
    600: Color(0xFFA52044),
    700: Color(0xFF9B1B3B),
    800: Color(0xFF921633),
    900: Color(0xFF820D23),
  });

  static const MaterialColor accentSecondary = MaterialColor(accentSecondaryValue, <int, Color>{
    100: Color(0xFFFFB3BF),
    200: Color(accentSecondaryValue),
    400: Color(0xFFFF4D69),
    700: Color(0xFFFF3453),
  });

  static const int accentSecondaryValue = 0xFFFF8094;
  static const Color accentSecondaryColor = Color(0xFFFF8094);

  static const int secondaryColorValue = 0xFFAC244B;
  static const Color secondaryColor = Color(0xFFAC244B);

//======================================================================//
  ///normal color codes
  static const m8F9394 = Color(0xFF8F9394);
  static const m6B6D6C = Color(0xFF6B6D6C);
  static const mD0D0D0 = Color(0xFFD0D0D0);
  static const m272727 = Color(0xDC272727);
  static const m222222 = Color(0xFF222222);
  static const m111111 = Color(0xFF111111);
  static const m707070 = Color(0xFF707070);
  static const mCCCCCC = Color(0xFFCCCCCC);
  static const mED1F24 = Color(0xFFED1F24);
  static const mFF9C00 = Color(0xFFFF9C00);
  static const m04B700 = Color(0xFF04B700);
  static const m3D3D3D = Color(0xFF3D3D3D);
  static const mWhite = Color(0xFFFFFFFF);
  static const kYankeesBlue = Color(0xFF14213D);
  static const mBlack = Color(0xFF000000);
  static const m101010 = Color(0xFF101010);
  static const mBlack40 = Color(0x40000000);
  static const mGreen = Color(0xFF75DB58);
  static const m87859A = Color(0xFF87859A);
  static const mEFF5F5 = Color(0xFFEFF5F5);
  static const mB6B6B6 = Color(0xFFB6B6B6);
  static const m343434 = Color(0xFF343434);
  static const mBlueMore = Color(0xFF5583EC);
  static const m949494 = Color(0xFF949494);
  static const m292929 = Color(0xFF292929);
  static const m5583EC = Color(0xFF5583EC);
  static const m8DC640 = Color(0xFF8DC640);
  static const mFFAA64 = Color(0xFFFFAA64);
  static const mC6C6C6 = Color(0xFFC6C6C6);
  static const mE6EDFF = Color(0xFFE6EDFF);
  static const m7A8FA6 = Color(0xFF7A8FA6);
  static const m747474 = Color(0xFF747474);
  static const mACACAC = Color(0xFFACACAC);
  static const mE2E2E2 = Color(0xFFE2E2E2);
  static const m8F7EFF = Color(0xFF8F7EFF);
  static const m0A77E8 = Color(0xFF0A77E8);
  static const m232C40 = Color(0xFF232C40);
  static const m5D9CF7 = Color(0xFF5D9CF7);
  static const mFA5D5D = Color(0xFFFA5D5D);
  static const mAF7A7C = Color(0xFFAF7A7C);
  static const mE6E6E6 = Color(0xFFE6E6E6);
  static const m7D8DB5 = Color(0xFF7D8DB5);
  static const m25396F = Color(0xFF25396F);
  static const m5DB7F9 = Color(0xFF5DB7F9);
  static const mF7FFF5 = Color(0xFFF7FFF5);
  static const mE6EFFB = Color(0x79E6EFFB);
  static const mPurple = Color(0xFFB000F9);
  static const mPurpleLight = Color(0xFFCB75EE);
  static const mEDEDED = Color(0xFFEDEDED);
  static const m8D8D8D = Color(0xFF8D8D8D);
  static const mCBCBCB = Color(0xFFCBCBCB);
  static const mA5A5A5 = Color(0xFFA5A5A5);
  static const mFCF1FF = Color(0xFFFCF1FF);
  static const m777777 = Color(0xFF777777);
  static const mF9E2E2 = Color(0xFFF9E2E2);
  static const mFCD9D9 = Color(0xFFFCD9D9);
  static const redNormal = Color(0xFFFFB7B7);
  static const redLight = Color(0xFFFDB9B9);
  static const blueNormal = Color(0xFFD2ECFE);
  static const greenNormal = Color(0xFFB8E986);
  static const mOrange = Color(0xFFF5A623);
  static const mF9EDD9 = Color(0xFFF9EDD9);
  static const mE6E1E1 = Color(0xFFE6E1E1);
  static const mB8AEF9 = Color(0xFFB8AEF9);
  static const mF5F5F5 = Color(0xFFF5F5F5);
  static const mB0B6C3 = Color(0xFFB0B6C3);
  static const m353535 = Color(0xFF353535);
}
