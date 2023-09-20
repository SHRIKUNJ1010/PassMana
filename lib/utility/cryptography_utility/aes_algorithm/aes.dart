/*
* Created by Shrikunj Patel on 9/19/2023.
*/

import 'package:passmana/utility/cryptography_utility/aes_algorithm/aes_common_constants.dart';

class AES {
  //========================================= Common Helper Functions ==================================//

  //generates list of round key for every round fo encryption and decryption
  //as per the length of given key which would be 128,192 or 256
  // 128 -> 10 keys
  // 192 -> 12 keys
  // 256 -> 14 keys
  static List<List<int>> keyExpansion() {
    return [];
  }

  //this function performs operation between given plain text block (state or matrix) for
  // the particular round with given round key
  static List<int> addRoundKey({
    List<int> roundKey = const [],
    List<int> state = const [],
  }) {
    return [];
  }

  //================================================== Encryption Helper Functions ========================================//

  // this function performs substitution using s_box on state
  static List<int> subBytes({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> mixColumns({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> shiftRows({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> cipher({
    List<int> state = const [],
    required AESType type,
    List<List<int>> roundKeys = const [],
  }) {
    List<int> value = state;
    AESData data = AESConstants.getAESData(type: type);
    //add first round key
    value = addRoundKey(state: value, roundKey: roundKeys[0]);
    //from 1 to 12,10,8 according to algorithm type
    for (int i = 1; i < data.numberOfRounds - 1; i++) {
      value = subBytes(state: value);
      value = shiftRows(state: value);
      value = mixColumns(state: value);
      value = addRoundKey(state: value, roundKey: roundKeys[i]);
    }
    value = subBytes(state: value);
    value = shiftRows(state: value);
    //add last round key
    value = addRoundKey(state: value, roundKey: roundKeys[data.numberOfRounds - 1]);
    return value;
  }

  //================================================== Decryption Helper Functions ========================================//

  // this function performs substitution using inverse_s_box on state
  static List<int> inverseSubBytes({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> inverseMixColumns({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> inverseShiftRows({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> inverseCipher({
    List<int> state = const [],
    required AESType type,
    List<List<int>> roundKeys = const [],
  }) {
    List<int> value = state;
    AESData data = AESConstants.getAESData(type: type);

    //add last round key
    value = addRoundKey(state: value, roundKey: roundKeys[data.numberOfRounds - 1]);

    for (int i = data.numberOfRounds - 2; i > 0; i--) {
      value = inverseShiftRows(state: value);
      value = inverseSubBytes(state: value);
      value = addRoundKey(state: value, roundKey: roundKeys[i]);
      value = inverseMixColumns(state: value);
    }
    value = inverseShiftRows(state: value);
    value = inverseSubBytes(state: value);
    //add first round key
    value = addRoundKey(state: value, roundKey: roundKeys[0]);

    return value;
  }

  //================================================== Encryption And Decryption Functions ========================================//

  // this function is used to encrypt data
  static String encrypt({
    required String plainText,
    required String key,
    AESType type = AESType.aes256,
  }) {
    return '';
  }

  // this function is used to decrypt data
  static String decrypt({
    required String cipherText,
    required String key,
    AESType type = AESType.aes256,
  }) {
    return '';
  }
}
