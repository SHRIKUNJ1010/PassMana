/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/group_model.dart';

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
      ),
    );
  }

  updateGroup({required Group group}) {
    _groupBox.put(group);
  }

  List<Group> getAllGroups() {
    return _groupBox.getAll();
  }

  Group? getOneGroup(int groupId) {
    return _groupBox.get(groupId);
  }

  deleteGroup(int groupId) {
    _groupBox.remove(groupId);
  }
}
