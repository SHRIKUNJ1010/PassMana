/*
* Created by Shrikunj Patel on 9/19/2023.
*/

import 'package:passmana/utility/cryptography_utility/aes_algorithm/aes_constants.dart';
import 'dart:convert';

class AES {
  //========================================= Common Helper Functions ==================================//

  //convert String to List of blocks of 16bytes(128bits)
  static List<List<int>> _getByteBlocksFromString(String text) {
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
  static String _getStringFromByteBlocks(List<List<int>> byteBlocks) {
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

  //converting string in byte array without blocks this will be used by key expansion for
  // converting key in usable form for algorithm
  static List<int> _getByteListFromString(String value) {
    List<int> tempArray = [];
    for (int i = 0; i < value.length; i++) {
      //byte value from character
      tempArray.add(value[i].codeUnits.first);
    }
    return tempArray;
  }

  //converting byte list in string
  static String _getStringFromByteList(List<int> value) {
    String temp = utf8.decode(value);
    return temp.trim();
  }

  //generates list of round key for every round fo encryption and decryption
  //as per the length of given key which would be 128,192 or 256
  // 128 -> 11 keys (number of rounds + 1)
  // 192 -> 13 keys (number of rounds + 1)
  // 256 -> 15 keys (number of rounds + 1)
  //this round keys would be of 16 bytes (same as state of one block)
  static List<List<int>> _keyExpansion({
    List<int> byteListOfKey = const [],
  }) {
    List<List<int>> tempKeys = [];

    return tempKeys;
  }

  //this function performs operation between given plain text block (state or matrix) for
  // the particular round with given round key
  static List<int> _addRoundKey({
    List<int> roundKey = const [],
    List<int> state = const [],
  }) {
    return [];
  }

  //================================================== key Expansion Helper Functions ========================================//

  // this function performs rotation of array of 4 integers
  static List<int> _rotWord({
    List<int> array = const [],
  }) {
    //if array is not empty then only perform operations
    if (array.isNotEmpty) {
      List<int> temp = array;
      //first value stored in temp variable
      int tempData = array[0];
      // traversing through array
      for (int i = 0; i < array.length; i++) {
        // if array element is not last element then assign value of next array element in this element
        if (i != array.length - 1) {
          array[i] = array[i + 1];
        }
        //if array element is last element then assign value of first array element stored in tempData
        else {
          array[i] = tempData;
        }
      }

      return temp;
    }
    //if array is empty then return empty array without any operations
    else {
      return [];
    }
  }

  //this function performs substitution using s box for given 4 bytes
  // directly calling sub bytes function because sub bytes function generated here
  // works for any length of array whether its state of length 16 or word of length 4
  static List<int> _subWord({
    List<int> array = const [],
  }) {
    List<int> temp = _subBytes(state: array);
    return temp;
  }

  //================================================== Encryption Helper Functions ========================================//

  // this function performs substitution using s_box on state
  static List<int> _subBytes({
    List<int> state = const [],
  }) {
    List<int> temp = [];
    for (int i = 0; i < state.length; i++) {
      temp.add(AESConstants.sBox[state[i]]);
    }
    return temp;
  }

  static List<int> _mixColumns({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> _shiftRows({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> _cipher({
    List<int> state = const [],
    required AESType type,
    List<List<int>> roundKeys = const [],
  }) {
    //get this block state data
    List<int> value = state;
    //get aes data which changes according to algorithm type
    AESData data = AESConstants.getAESData(type: type);
    //add first round key
    value = _addRoundKey(state: value, roundKey: roundKeys[0]);
    //from 1 to 13,11,9 (number of round - 1) according to algorithm type
    for (int i = 1; i <= data.numberOfRounds - 1; i++) {
      //call sub bytes function for this round
      value = _subBytes(state: value);
      //call shift rows function for this round
      value = _shiftRows(state: value);
      //call mix columns function for this round
      value = _mixColumns(state: value);
      //call add round key function for this round key
      value = _addRoundKey(state: value, roundKey: roundKeys[i]);
    }
    //call sub bytes function for this last round
    value = _subBytes(state: value);
    //call shift rows function for this last round
    value = _shiftRows(state: value);
    //add last round key
    value = _addRoundKey(state: value, roundKey: roundKeys[data.numberOfRounds]);
    return value;
  }

  //================================================== Decryption Helper Functions ========================================//

  // this function performs substitution using inverse_s_box on state
  static List<int> _inverseSubBytes({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> _inverseMixColumns({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> _inverseShiftRows({
    List<int> state = const [],
  }) {
    return [];
  }

  static List<int> _inverseCipher({
    List<int> state = const [],
    required AESType type,
    List<List<int>> roundKeys = const [],
  }) {
    //get this block state data
    List<int> value = state;
    //get aes data which changes according to algorithm type
    AESData data = AESConstants.getAESData(type: type);
    //add last round key(first time)
    value = _addRoundKey(state: value, roundKey: roundKeys[data.numberOfRounds]);

    //perform for second last round key second round
    for (int i = data.numberOfRounds - 1; i > 0; i--) {
      //call inverse shift rows for this round
      value = _inverseShiftRows(state: value);
      //call inverse sub bytes for this round
      value = _inverseSubBytes(state: value);
      //add round key for this round (from second last round key to second round key)
      value = _addRoundKey(state: value, roundKey: roundKeys[i]);
      //call inverse mix columns for this round
      value = _inverseMixColumns(state: value);
    }
    //call inverse shift rows for first round(last time)
    value = _inverseShiftRows(state: value);
    //call inverse sub bytes for first round(last time)
    value = _inverseSubBytes(state: value);
    //add first round key (last time)
    value = _addRoundKey(state: value, roundKey: roundKeys[0]);
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
    List<List<int>> plainTextByteBlocks = _getByteBlocksFromString(plainText);
    //byte list of key
    List<int> byteListOfKey = _getByteListFromString(key);
    //generate round keys using key expansion function which uses given key
    List<List<int>> roundKeysBlocks = _keyExpansion(byteListOfKey: byteListOfKey);

    for (List<int> i in plainTextByteBlocks) {
      //call cipher function for particular 16 bytes block and add cipher text which is
      //returned into cipher text byte blocks
      cipherTextByteBlocks.add(_cipher(type: type, state: i, roundKeys: roundKeysBlocks));
    }
    //convert cipher text byte blocks into cipher text string
    cipherText = _getStringFromByteBlocks(cipherTextByteBlocks);
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
    List<List<int>> cipherTextByteBlocks = _getByteBlocksFromString(plainText);
    //byte list of key
    List<int> byteListOfKey = _getByteListFromString(key);
    //generate round keys using key expansion function which uses given key
    List<List<int>> roundKeysBlocks = _keyExpansion(byteListOfKey: byteListOfKey);

    for (List<int> i in cipherTextByteBlocks) {
      //call inverse cipher function for particular 16 bytes block and add plain text which is
      //returned into plain text byte blocks
      plainTextByteBlocks.add(_inverseCipher(type: type, state: i, roundKeys: roundKeysBlocks));
    }
    //convert plain text byte blocks into plain text string
    plainText = _getStringFromByteBlocks(plainTextByteBlocks);
    //return generated plain text
    return plainText;
  }
}
