/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/objectbox.g.dart';

class GroupBox {
  late final Box<Group> _groupBox;

  GroupBox(Store store) {
    _groupBox = Box<Group>(store);
  }

  addGroup({
    String groupName = '',
    String description = '',
  }) {
    _groupBox.put(
      Group(
        groupName: groupName,
        description: description,
        createdOn: DateTime.now(),
        lastUpdatedOn: DateTime.now(),
      ),
      mode: PutMode.insert,
    );
  }

  updateGroup({
    required Group group,
  }) {
    _groupBox.put(
      group,
      mode: PutMode.update,
    );
  }

  List<Group> getAllGroups() {
    return _groupBox.getAll();
  }

  addAllGroups(List<Group> tempGroups) {
    _groupBox.putMany(tempGroups);
  }

  List<Group> getPopularGroups() {
    //take all groups from object box
    final List<Group> allGroups = _groupBox.getAll();
    //sort all groups based on passwords list length in descending order
    allGroups.sort((a, b) => b.passwords.length.compareTo(a.passwords.length));
    //take first 4 groups which would have most passwords in the list
    final List<Group> tempList = allGroups.take(4).toList();
    return tempList;
  }

  Group? getOneGroup(int groupId) {
    return _groupBox.get(groupId);
  }

  deleteGroup(int groupId) {
    _groupBox.remove(groupId);
  }
}
