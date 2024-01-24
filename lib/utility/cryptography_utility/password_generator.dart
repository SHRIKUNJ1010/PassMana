/*
* Created by Shrikunj Patel on 1/24/2024.
*/

import 'dart:math';

class PasswordGenerator {
  static String generateRandomPassword({
    required int length,
    required bool withLowerCase,
    required bool withUpperCase,
    required bool withSpecialChar,
    required bool withDigits,
  }) {
    //constants for generating password
    const String specialCharacters = "!@#\$%^&*-+?=_~";
    const String digits = "0123456789";
    const String lowerCaseCharacters = "aeioubcdfghjklmnpqrstvwxyz";
    const String upperCaseCharacters = "AEIOUBCDFGHJKLMNPQRSTVWXYZ";
    final random = Random();

    //available character to generate the password from
    String characterList = "";
    if (withLowerCase) characterList += lowerCaseCharacters;
    if (withUpperCase) characterList += upperCaseCharacters;
    if (withSpecialChar) characterList += specialCharacters;
    if (withDigits) characterList += digits;

    //generated temp password variable
    String tempPassword = "";
    for (int i = 0; i < length; i++) {
      tempPassword += characterList[random.nextInt(characterList.length)];
    }
    return tempPassword;
  }

  static String generatePronounceablePassword({
    required int length,
    required bool withLowerCase,
    required bool withUpperCase,
    required bool withSpecialChar,
    required bool withDigits,
  }) {
    //constants for generating password
    const String vowels = 'aeiou';
    const String vowelsUpperCase = 'AEIOU';
    const String consonants = 'bcdfghjklmnpqrstvwxyz';
    const String consonantsUpperCase = 'BCDFGHJKLMNPQRSTVWXYZ';
    const String specialCharacters = '!@#\$%^&*-+?=_~';
    const String digits = '0123456789';
    final random = Random();

    //generated password temp variable
    String tempPassword = "";

    //variable for looping through the generating password length
    int tempLength = length;

    //how many characters to leave for at the end of the password for digits or special characters
    int remainingLength = 0 + (withDigits ? 2 : 0) + (withSpecialChar ? 1 : 0);

    //traverse the length of password for generating
    while (tempLength > remainingLength) {
      //with lower case and upper case
      if (withUpperCase && withLowerCase) {
        // add one consonant followed by one vowel to make your password more readable
        tempPassword += random.nextBool() ? consonantsUpperCase[random.nextInt(consonants.length)] : consonants[random.nextInt(consonants.length)];
        tempLength--;
        if (tempLength > remainingLength) {
          tempPassword += random.nextBool() ? vowelsUpperCase[random.nextInt(vowels.length)] : vowels[random.nextInt(vowels.length)];
          tempLength--;
        }
        // only upper case
      } else if (withUpperCase && !withLowerCase) {
        tempPassword += consonantsUpperCase[random.nextInt(consonants.length)];
        tempLength--;
        if (tempLength > remainingLength) {
          tempPassword += vowelsUpperCase[random.nextInt(vowels.length)];
          tempLength--;
        }
        //only lower case
      } else if (!withUpperCase && withLowerCase) {
        tempPassword += consonants[random.nextInt(consonants.length)];
        tempLength--;
        if (tempLength > remainingLength) {
          tempPassword += vowels[random.nextInt(vowels.length)];
          tempLength--;
        }
      } else {
        //do nothing
      }
    }

    //add one special character if with special character
    if (withSpecialChar) {
      tempPassword += specialCharacters[random.nextInt(specialCharacters.length)];
    }

    //add two digits if with digits
    if (withDigits) {
      tempPassword += digits[random.nextInt(digits.length)];
      tempPassword += digits[random.nextInt(digits.length)];
    }

    return tempPassword;
  }
}
