/*
* Created by Shrikunj Patel on 9/14/2023.
*/

import 'package:flutter/services.dart';
import 'package:passmana/utility/method_channel_utility/method_channel_constants.dart';
import 'package:passmana/utility/utility.dart';

class BiometricsChannel {
  //biometrics method channel
  static const _biometricsChannel = MethodChannel(MethodChannelConstants.biometricVerificationChannel);

  //method to verify biometric for android or ios
  static Future<bool> verifyBiometric() async {
    try {
      bool? result = await _biometricsChannel.invokeMethod<bool>(MethodChannelConstants.verifyBiometricMethod);
      return (result ?? false);
    } catch (e) {
      Utility.printLog(e.toString());
      return false;
    }
  }
}
