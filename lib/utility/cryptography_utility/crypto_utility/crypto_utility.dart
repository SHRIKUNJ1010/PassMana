/*
Created By Shrikunj on 20/12/24
*/

import 'package:encrypt/encrypt.dart' as encrypt;
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
    if (plainText.isEmpty) return "";
    final encryptor = encrypt.Encrypter(encrypt.AES(await _getAlgoKey(), mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    return encryptor.encrypt(plainText, iv: await _getAlgoIV()).base64;
  }

  static Future<String> decryptText(String cipherText) async {
    if (cipherText.isEmpty) return "";
    final encryptor = encrypt.Encrypter(encrypt.AES(await _getAlgoKey(), mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    return encryptor.decrypt(encrypt.Encrypted.fromBase64(cipherText), iv: await _getAlgoIV());
  }

  static Future<List<String>> encryptWithExternalIvAndAlgoKey(String plainText) async {
    encrypt.IV tempIv = await _getAlgoIV();
    encrypt.Key tempKey = await _getAlgoKey();
    if (plainText.isEmpty) return ["", tempIv.base64, tempKey.base64];
    final encryptor = encrypt.Encrypter(encrypt.AES(tempKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    return [encryptor.encrypt(plainText, iv: tempIv).base64, tempIv.base64, tempKey.base64];
  }

  static Future<String> externalIvDecryptText({
    required String cipherText,
    required String iv,
    required String key,
  }) async {
    encrypt.IV tempIv = encrypt.IV.fromBase64(iv);
    encrypt.Key tempKey = encrypt.Key.fromBase64(key);
    if (cipherText.isEmpty) return "";
    final encryptor = encrypt.Encrypter(encrypt.AES(tempKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    return encryptor.decrypt(encrypt.Encrypted.fromBase64(cipherText), iv: tempIv);
  }
}
