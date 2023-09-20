/*
* Created by Shrikunj Patel on 9/19/2023.
*/

enum AESType { aes256, aes192, aes128 }

class AESData {
  final int keyLength;
  final int numberOfRounds;

  AESData({
    required this.keyLength,
    required this.numberOfRounds,
  });
}

class AESConstants {
  //this algorithm would by default use aes 256 algorithm
  // if you want use different algorithm then pass different type
  static AESData getAESData({AESType type = AESType.aes256}) {
    switch (type) {
      case AESType.aes256:
        return AESData(keyLength: 256, numberOfRounds: 14);
      case AESType.aes192:
        return AESData(keyLength: 192, numberOfRounds: 12);
      case AESType.aes128:
        return AESData(keyLength: 128, numberOfRounds: 10);
    }
  }
}
