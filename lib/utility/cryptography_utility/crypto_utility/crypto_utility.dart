/*
Created By Shrikunj on 20/12/24
*/

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CryptoUtility {
  static const String _algoKeyStore = "algo_key_store";
  static const String _ivKeyStore = "iv_key_store";

  static final _storage = FlutterSecureStorage();

  static Future<encrypt.Key> _getAlgoKey() async {
    String? tempAlgoKey = await _storage.read(key: _algoKeyStore);
    encrypt.Key? key;
    if (tempAlgoKey == null) {
      key = encrypt.Key.fromLength(32);
      await _storage.write(key: _algoKeyStore, value: key.base64);
    } else {
      key = encrypt.Key.fromBase64(tempAlgoKey);
    }
    return key;
  }

  static Future<encrypt.IV> _getAlgoIV() async {
    String? tempAlgoIV = await _storage.read(key: _ivKeyStore);
    encrypt.IV? iv;
    if (tempAlgoIV == null) {
      iv = encrypt.IV.fromLength(16);
      await _storage.write(key: _ivKeyStore, value: iv.base64);
    } else {
      iv = encrypt.IV.fromBase64(tempAlgoIV);
    }
    return iv;
  }

  static Future<String> encryptText(String plainText) async {
    final encryptor = encrypt.Encrypter(encrypt.AES(await _getAlgoKey()));
    return encryptor.encrypt(plainText, iv: await _getAlgoIV()).base64;
  }

  static Future<String> decryptText(String cipherText) async {
    final encryptor = encrypt.Encrypter(encrypt.AES(await _getAlgoKey()));
    return encryptor.decrypt(encrypt.Encrypted(Uint8List.fromList(cipherText.codeUnits)), iv: await _getAlgoIV());
  }
}
