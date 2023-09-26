/*
* Created by Shrikunj Patel on 9/19/2023.
*/

import 'package:passmana/utility/cryptography_utility/aes_algorithm/aes_common_constants.dart';
import 'dart:convert';

class AES {
  //========================================= Common Helper Functions ==================================//

  //convert String to List of blocks of 16bytes(128bits)
  static List<List<int>> getByteBlocksFromString(String text) {
    //get list of characters from string
    List<String> splitString = text.split('');

    //for converting string into block of 16 bytes(characters) the string length is required of multiplication of 16 (0,16,32,...)
    int remainingCharacters = splitString.length % 16;

    //add blank spaces for remaining characters
    if (remainingCharacters != 0) {
      for (int v = 0; v < (16 - remainingCharacters); v++) {
        splitString.add(' ');
      }
    }

    List<List<int>> tempList = [];

    //loop for each block of 16 characters
    for (int i = 0; i < splitString.length; i += 16) {
      List<int> temp = [];
      //loop for one block from 0...15
      for (int j = 0; j < 16; j++) {
        //convert character to byte integer
        List<int> byteTemp = splitString[i + j].codeUnits;
        //add to byte to its block
        temp.add(byteTemp.first);
      }
      //add block to its block list
      tempList.add(temp);
    }
    return tempList;
  }

  //converting List of blocks of 16bytes(128bits) to String
  static String getStringFromByteBlocks(List<List<int>> byteBlocks) {
    String decodedData = '';
    //loop through all blocks
    for (List<int> i in byteBlocks) {
      //decode list<int> block into string
      String temp = utf8.decode(i);
      //append decoded string
      decodedData += temp;
    }
    //remove blank spaces from back of the string which are added to adjust string length into multiples of 16
    return decodedData.trim();
  }

  //generates list of round key for every round fo encryption and decryption
  //as per the length of given key which would be 128,192 or 256
  // 128 -> 10 keys
  // 192 -> 12 keys
  // 256 -> 14 keys
  //this round keys would be of 16 bytes (same as state of one block)
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
    //get this block state data
    List<int> value = state;
    //get aes data which changes according to algorithm type
    AESData data = AESConstants.getAESData(type: type);
    //add first round key
    value = addRoundKey(state: value, roundKey: roundKeys[0]);
    //from 1 to 12,10,8 according to algorithm type
    for (int i = 1; i < data.numberOfRounds - 1; i++) {
      //call sub bytes function for this round
      value = subBytes(state: value);
      //call shift rows function for this round
      value = shiftRows(state: value);
      //call mix columns function for this round
      value = mixColumns(state: value);
      //call add round key function for this round key
      value = addRoundKey(state: value, roundKey: roundKeys[i]);
    }
    //call sub bytes function for this last round
    value = subBytes(state: value);
    //call shift rows function for this last round
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
    //get this block state data
    List<int> value = state;
    //get aes data which changes according to algorithm type
    AESData data = AESConstants.getAESData(type: type);
    //add last round key(first time)
    value = addRoundKey(state: value, roundKey: roundKeys[data.numberOfRounds - 1]);

    //perform for second last round key second round
    for (int i = data.numberOfRounds - 2; i > 0; i--) {
      //call inverse shift rows for this round
      value = inverseShiftRows(state: value);
      //call inverse sub bytes for this round
      value = inverseSubBytes(state: value);
      //add round key for this round (from second last round key to second round key)
      value = addRoundKey(state: value, roundKey: roundKeys[i]);
      //call inverse mix columns for this round
      value = inverseMixColumns(state: value);
    }
    //call inverse shift rows for first round(last time)
    value = inverseShiftRows(state: value);
    //call inverse sub bytes for first round(last time)
    value = inverseSubBytes(state: value);
    //add first round key (last time)
    value = addRoundKey(state: value, roundKey: roundKeys[0]);
    //return this cipher block
    return value;
  }

  //================================================== Encryption And Decryption Functions ========================================//

  // this function is used to encrypt data
  static String encrypt({
    required String plainText,
    required String key,
    AESType type = AESType.aes256,
  }) {
    //cipher text String value which will be returned from this function
    String cipherText = '';
    //cipher text byte blocks
    List<List<int>> cipherTextByteBlocks = [];
    //plain text byte blocks (convert String into byte blocks)
    List<List<int>> plainTextByteBlocks = getByteBlocksFromString(plainText);
    //generate round keys using key expansion function which uses given key
    List<List<int>> roundKeysBlocks = keyExpansion();

    for (List<int> i in plainTextByteBlocks) {
      //call cipher function for particular 16 bytes block and add cipher text which is
      //returned into cipher text byte blocks
      cipherTextByteBlocks.add(cipher(type: type, state: i, roundKeys: roundKeysBlocks));
    }
    //convert cipher text byte blocks into cipher text string
    cipherText = getStringFromByteBlocks(cipherTextByteBlocks);
    //return generated cipher text
    return cipherText;
  }

  // this function is used to decrypt data
  static String decrypt({
    required String cipherText,
    required String key,
    AESType type = AESType.aes256,
  }) {
    //plain text String value which will be returned from this function
    String plainText = '';
    //plain text byte blocks
    List<List<int>> plainTextByteBlocks = [];
    //cipher text byte blocks (convert String into byte blocks)
    List<List<int>> cipherTextByteBlocks = getByteBlocksFromString(plainText);
    //generate round keys using key expansion function which uses given key
    List<List<int>> roundKeysBlocks = keyExpansion();

    for (List<int> i in cipherTextByteBlocks) {
      //call inverse cipher function for particular 16 bytes block and add plain text which is
      //returned into plain text byte blocks
      plainTextByteBlocks.add(inverseCipher(type: type, state: i, roundKeys: roundKeysBlocks));
    }
    //convert plain text byte blocks into plain text string
    plainText = getStringFromByteBlocks(plainTextByteBlocks);
    //return generated plain text
    return plainText;
  }
}
