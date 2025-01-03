import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:passmana/main.dart';
import 'package:passmana/model/card_model.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';
import 'package:passmana/utility/utility.dart';
import 'package:path_provider/path_provider.dart';

class ImportExportDatabase {
  static Future<String> export() async {
    Map<String, dynamic> exportingData = {
      'password': null,
      'secret_note': null,
      'group': null,
      'card': null,
    };
    exportingData['password'] = (await objectBox.passwordBox.getAllPasswords()).map((e) => e.toJson()).toList();
    exportingData['secret_note'] = (await objectBox.secretNoteBox.getAllSecretNote()).map((e) => e.toJson()).toList();
    exportingData['group'] = (await objectBox.groupBox.getAllGroups()).map((e) => e.toJson()).toList();
    exportingData['card'] = (await objectBox.cardBox.getAllCards()).map((e) => e.toJson()).toList();

    List<String> jsonEncoded = await CryptoUtility.encryptWithExternalIvAndAlgoKey(jsonEncode(exportingData));
    List<int> utf8encoded = utf8.encode(jsonEncoded.join("!!!!!!!!!!"));
    final archiveFile = ArchiveFile('db_file.text', utf8encoded.length, utf8encoded);
    final archive = Archive()..addFile(archiveFile);
    final encodedArchive = ZipEncoder().encode(archive);
    Directory? appDir = (Platform.isAndroid ? await getExternalStorageDirectory() : await getDownloadsDirectory());
    if (appDir == null) return '';
    await File('${appDir.path}/db_file.zip').writeAsBytes(encodedArchive);
    return '${appDir.path}/db_file.zip';
  }

  static Future<void> import(String filePath) async {
    List<Password> tempPasswords = <Password>[];
    List<Group> tempGroups = <Group>[];
    List<Card> tempCards = <Card>[];
    List<SecretNote> tempSecretNotes = <SecretNote>[];
    if (!filePath.contains('.zip')) return;
    final Uint8List tempData = await File(filePath).readAsBytes();
    final decodedFile = ZipDecoder().decodeBytes(tempData).first;

    if (decodedFile.isFile) {
      List<String> encryptedUtf8 = utf8.decode(decodedFile.readBytes() ?? []).trim().split("!!!!!!!!!!");
      String utf8Decoded = await CryptoUtility.externalIvDecryptText(
        cipherText: encryptedUtf8[0],
        iv: encryptedUtf8[1],
        key: encryptedUtf8[2],
      );
      Map<String, dynamic> jsonData = jsonDecode(utf8Decoded);
      if (jsonData['group'] != null) {
        jsonData['group'].forEach((v) {
          tempGroups.add(Group.fromJson(v));
        });
        await objectBox.groupBox.addAllGroups(tempGroups);
      }
      if (jsonData['password'] != null) {
        jsonData['password'].forEach((v) {
          Password tempPass = Password.fromJson(v);
          if (v['target_group'] != null) {
            try {
              Group? tempGroup = tempGroups.singleWhere((element) => element.id == v['target_group']);
              tempPass.group.target = tempGroup;
            } catch (e) {
              Utility.printLog(e.toString());
            }
          }
          tempPasswords.add(tempPass);
        });
        await objectBox.passwordBox.addAllPasswords(tempPasswords);
      }
      if (jsonData['card'] != null) {
        jsonData['card'].forEach((v) {
          tempCards.add(Card.fromJson(v));
        });
        await objectBox.cardBox.addAllCards(tempCards);
      }
      if (jsonData['secret_note'] != null) {
        jsonData['secret_note'].forEach((v) {
          tempSecretNotes.add(SecretNote.fromJson(v));
        });
        await objectBox.secretNoteBox.addAllSecretNote(tempSecretNotes);
      }
    }
    return;
  }
}
