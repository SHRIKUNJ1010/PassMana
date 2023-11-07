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
    //this byte list length would be 16 for 128,24 for 192 and 32 for 256
  }) {
    //temp round keys round + 1 length of array with 16 length of arrays
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
    //TODO: check this function again
    /*
    [01,02,03,04]
    [05,06,07,08]
    [09,10,11,12]
    [13,14,15,16]
    for mix column operation below matrix multiplication is done
    [2,3,1,1]   [a,b,c,d]    [(2a + 1m + 3e + 1i), (1j + 1n + 2b + 3f), (1k + 1o + 2c + 3g), (1l + 1p + 2d + 3h)]
    [1,2,3,1] * [e,f,g,h] => [(1a + 1m + 2e + 3i), (3j + 1n + 1b + 2f), (3k + 1o + 1c + 2g), (3l + 1p + 1d + 2h)]
    [1,1,2,3]   [i,j,k,l]    [(1a + 3m + 1e + 2i), (2j + 3n + 1b + 1f), (2k + 3o + 1c + 1g), (2l + 3p + 1d + 1h)]
    [3,1,1,2]   [m,n,o,p]    [(3a + 2m + 1e + 1i), (1j + 2n + 3b + 1f), (1k + 2o + 3c + 1g), (1l + 2p + 3d + 1h)]
     */
    List<int> tempState = [];
    //first column
    tempState.add((2 * state[0]) + (1 * state[12]) + (3 * state[4]) + (1 * state[8]));
    tempState.add((1 * state[0]) + (1 * state[12]) + (2 * state[4]) + (3 * state[8]));
    tempState.add((1 * state[0]) + (3 * state[12]) + (1 * state[4]) + (2 * state[8]));
    tempState.add((3 * state[0]) + (2 * state[12]) + (1 * state[4]) + (1 * state[8]));
    //second column
    tempState.add((1 * state[9]) + (1 * state[13]) + (2 * state[1]) + (3 * state[5]));
    tempState.add((3 * state[9]) + (1 * state[13]) + (1 * state[1]) + (2 * state[5]));
    tempState.add((2 * state[9]) + (3 * state[13]) + (1 * state[1]) + (1 * state[5]));
    tempState.add((1 * state[9]) + (2 * state[13]) + (3 * state[1]) + (1 * state[5]));
    //third column
    tempState.add((1 * state[10]) + (1 * state[14]) + (2 * state[2]) + (3 * state[6]));
    tempState.add((3 * state[10]) + (1 * state[14]) + (1 * state[2]) + (2 * state[6]));
    tempState.add((2 * state[10]) + (3 * state[14]) + (1 * state[2]) + (1 * state[6]));
    tempState.add((1 * state[10]) + (2 * state[14]) + (3 * state[2]) + (1 * state[6]));
    //fourth column
    tempState.add((1 * state[11]) + (1 * state[15]) + (2 * state[3]) + (3 * state[7]));
    tempState.add((3 * state[11]) + (1 * state[15]) + (1 * state[3]) + (2 * state[7]));
    tempState.add((2 * state[11]) + (3 * state[15]) + (1 * state[3]) + (1 * state[7]));
    tempState.add((1 * state[11]) + (2 * state[15]) + (3 * state[3]) + (1 * state[7]));

    return tempState;
  }

  static List<int> _shiftRows({
    List<int> state = const [],
  }) {
    //TODO: check this function
    /*
    after shifting matrix would look like
    [00,04,08,12]         [00,04,08,12]  // first row would remain same
    [01,05,09,13]    =>   [05,09,13,01]  // second row would be shifted one time (left shift)
    [02,06,10,14]    =>   [10,14,02,06]  // third row would be shifted two time (left shift)
    [03,07,11,15]         [15,03,07,11]  // fourth row would be shifted three time (left shift)
     */

    List<int> tempState = [];
    //first column after row shifting
    tempState.add(state[0]);
    tempState.add(state[5]);
    tempState.add(state[10]);
    tempState.add(state[15]);
    //second column after row shifting
    tempState.add(state[4]);
    tempState.add(state[9]);
    tempState.add(state[14]);
    tempState.add(state[3]);
    //third column after row shifting
    tempState.add(state[8]);
    tempState.add(state[13]);
    tempState.add(state[2]);
    tempState.add(state[7]);
    //forth column after row shifting
    tempState.add(state[12]);
    tempState.add(state[1]);
    tempState.add(state[6]);
    tempState.add(state[11]);
    //return shifted matrix array
    return tempState;
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
    List<int> temp = [];
    for (int i = 0; i < state.length; i++) {
      temp.add(AESConstants.inverseSBox[state[i]]);
    }
    return temp;
  }

  static List<int> _inverseMixColumns({
    List<int> state = const [],
  }) {
    //TODO: check this function again
    /*
    [01,02,03,04] [2,3,1,1]
    [05,06,07,08] [1,2,3,1]
    [09,10,11,12] [1,1,2,3]
    [13,14,15,16] [3,1,1,2]
    for mix column operation below matrix multiplication is done
    [14,11,13,09]   [a,b,c,d]    [(2a + 1m + 3e + 1i), (1j + 1n + 2b + 3f), (1k + 1o + 2c + 3g), (1l + 1p + 2d + 3h)]
    [09,14,11,13] * [e,f,g,h] => [(1a + 1m + 2e + 3i), (3j + 1n + 1b + 2f), (3k + 1o + 1c + 2g), (3l + 1p + 1d + 2h)]
    [13,09,14,11]   [i,j,k,l]    [(1a + 3m + 1e + 2i), (2j + 3n + 1b + 1f), (2k + 3o + 1c + 1g), (2l + 3p + 1d + 1h)]
    [11,13,09,14]   [m,n,o,p]    [(3a + 2m + 1e + 1i), (1j + 2n + 3b + 1f), (1k + 2o + 3c + 1g), (1l + 2p + 3d + 1h)]
     */
    List<int> tempState = [];
    //first column
    tempState.add((2 * state[0]) + (1 * state[12]) + (3 * state[4]) + (1 * state[8]));
    tempState.add((1 * state[0]) + (1 * state[12]) + (2 * state[4]) + (3 * state[8]));
    tempState.add((1 * state[0]) + (3 * state[12]) + (1 * state[4]) + (2 * state[8]));
    tempState.add((3 * state[0]) + (2 * state[12]) + (1 * state[4]) + (1 * state[8]));
    //second column
    tempState.add((1 * state[9]) + (1 * state[13]) + (2 * state[1]) + (3 * state[5]));
    tempState.add((3 * state[9]) + (1 * state[13]) + (1 * state[1]) + (2 * state[5]));
    tempState.add((2 * state[9]) + (3 * state[13]) + (1 * state[1]) + (1 * state[5]));
    tempState.add((1 * state[9]) + (2 * state[13]) + (3 * state[1]) + (1 * state[5]));
    //third column
    tempState.add((1 * state[10]) + (1 * state[14]) + (2 * state[2]) + (3 * state[6]));
    tempState.add((3 * state[10]) + (1 * state[14]) + (1 * state[2]) + (2 * state[6]));
    tempState.add((2 * state[10]) + (3 * state[14]) + (1 * state[2]) + (1 * state[6]));
    tempState.add((1 * state[10]) + (2 * state[14]) + (3 * state[2]) + (1 * state[6]));
    //fourth column
    tempState.add((1 * state[11]) + (1 * state[15]) + (2 * state[3]) + (3 * state[7]));
    tempState.add((3 * state[11]) + (1 * state[15]) + (1 * state[3]) + (2 * state[7]));
    tempState.add((2 * state[11]) + (3 * state[15]) + (1 * state[3]) + (1 * state[7]));
    tempState.add((1 * state[11]) + (2 * state[15]) + (3 * state[3]) + (1 * state[7]));

    return tempState;
  }

  static List<int> _inverseShiftRows({
    List<int> state = const [],
  }) {
    /*
    after inverse shifting matrix would look like
    [00,04,08,12]         [00,04,08,12]  // first row would remain same
    [01,05,09,13]    =>   [13,01,05,09]  // second row would be shifted one time inversely (right shift)
    [02,06,10,14]    =>   [10,14,02,06]  // third row would be shifted two time inversely (right shift)
    [03,07,11,15]         [07,11,15,03]  // fourth row would be shifted three time inversely (right shift)
     */
    List<int> tempState = [];
    //first column after row shifting
    tempState.add(state[0]);
    tempState.add(state[13]);
    tempState.add(state[10]);
    tempState.add(state[7]);
    //second column after row shifting
    tempState.add(state[4]);
    tempState.add(state[1]);
    tempState.add(state[14]);
    tempState.add(state[11]);
    //third column after row shifting
    tempState.add(state[8]);
    tempState.add(state[5]);
    tempState.add(state[2]);
    tempState.add(state[15]);
    //forth column after row shifting
    tempState.add(state[12]);
    tempState.add(state[9]);
    tempState.add(state[6]);
    tempState.add(state[3]);
    //return shifted matrix array
    return tempState;
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