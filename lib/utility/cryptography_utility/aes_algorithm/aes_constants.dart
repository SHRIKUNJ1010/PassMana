/*
* Created by Shrikunj Patel on 9/19/2023.
*/

enum AESType { aes256, aes192, aes128 }

class AESData {
  final int keyLength;
  final int numberOfRounds;
  final int nk;

  AESData({
    required this.keyLength,
    required this.numberOfRounds,
    required this.nk,
  });
}

class AESConstants {
  //this algorithm would by default use aes 256 algorithm
  // if you want use different algorithm then pass different type
  static AESData getAESData({AESType type = AESType.aes256}) {
    switch (type) {
      case AESType.aes256:
        return AESData(keyLength: 256, numberOfRounds: 14, nk: 8);
      case AESType.aes192:
        return AESData(keyLength: 192, numberOfRounds: 12, nk: 6);
      case AESType.aes128:
        return AESData(keyLength: 128, numberOfRounds: 10, nk: 4);
    }
  }

  //array of round constants used in key expansion function
  static const List<List<int>> roundConstants = [
    [01, 00, 00, 00],
    [02, 00, 00, 00],
    [04, 00, 00, 00],
    [08, 00, 00, 00],
    [16, 00, 00, 00],
    [32, 00, 00, 00],
    [64, 00, 00, 00],
    [128, 00, 00, 00],
    [27, 00, 00, 00],
    [54, 00, 00, 00],
  ];

  //inverse s box used in sub bytes function of decryption
  static const List<int> inverseSBox = [];

  // s box used in sub bytes function of encryption
  static const List<int> sBox = [];
}
