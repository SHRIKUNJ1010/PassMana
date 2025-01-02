/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/objectbox.g.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';

class GroupBox {
  late final Box<Group> _groupBox;

  GroupBox(Store store) {
    _groupBox = Box<Group>(store);
  }

  addGroup({
    String groupName = '',
    String description = '',
  }) async {
    String tempGroupName = await CryptoUtility.encryptText(groupName);
    String tempDescription = await CryptoUtility.encryptText(description);
    final tempGroupModel = Group(
      groupName: tempGroupName,
      description: tempDescription,
      createdOn: DateTime.now(),
      lastUpdatedOn: DateTime.now(),
    );

    await _groupBox.putAsync(
      tempGroupModel,
      mode: PutMode.insert,
    );
  }

  updateGroup({
    required int id,
    String groupName = '',
    String description = '',
  }) async {
    String tempGroupName = await CryptoUtility.encryptText(groupName);
    String tempDescription = await CryptoUtility.encryptText(description);

    final Group tempGroupModel = (await getOneGroup(id) ??
            Group(
              id: id,
              createdOn: DateTime.now(),
              lastUpdatedOn: DateTime.now(),
            ))
        .updateGroupInfo(
      groupName: tempGroupName,
      description: tempDescription,
      lastUpdatedOn: DateTime.now(),
    );

    await _groupBox.putAsync(
      tempGroupModel,
      mode: PutMode.update,
    );
  }

  Future<List<Group>> getAllGroups() async {
    List<Group> tempGroups = [];

    for (Group element in _groupBox.getAll()) {
      String tempGroupName = await CryptoUtility.encryptText(element.groupName);
      String tempDescription = await CryptoUtility.encryptText(element.description);
      tempGroups.add(
        element.updateGroupInfo(
          groupName: tempGroupName,
          description: tempDescription,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempGroups;
  }

  addAllGroups(List<Group> tempGroups) {
    //todo: check this for import/export data option
    _groupBox.putMany(tempGroups);
  }

  Future<List<Group>> getPopularGroups() async {
    //take all groups from object box
    final List<Group> allGroups = _groupBox.getAll();
    //sort all groups based on passwords list length in descending order
    allGroups.sort((a, b) => b.passwords.length.compareTo(a.passwords.length));
    //take first 4 groups which would have most passwords in the list
    final List<Group> tempList = allGroups.take(4).toList();
    List<Group> tempGroups = [];

    for (Group element in tempList) {
      String tempGroupName = await CryptoUtility.encryptText(element.groupName);
      String tempDescription = await CryptoUtility.encryptText(element.description);
      tempGroups.add(
        element.updateGroupInfo(
          groupName: tempGroupName,
          description: tempDescription,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempGroups;
  }

  Future<Group?> getOneGroup(int groupId) async {
    Group tempGroupValue = _groupBox.get(groupId) ??
        Group(
          id: groupId,
          createdOn: DateTime.now(),
          lastUpdatedOn: DateTime.now(),
        );
    String tempGroupName = await CryptoUtility.encryptText(tempGroupValue.groupName);
    String tempDescription = await CryptoUtility.encryptText(tempGroupValue.description);

    return tempGroupValue.updateGroupInfo(
      groupName: tempGroupName,
      description: tempDescription,
      lastUpdatedOn: tempGroupValue.lastUpdatedOn,
    );
  }

  deleteGroup(int groupId) async {
    await _groupBox.removeAsync(groupId);
  }
}
