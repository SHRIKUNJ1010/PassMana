/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/model/group_model.dart';

class GetAllGroups {}

class CreateGroup {
  final String groupName;
  final String description;

  CreateGroup({
    required this.groupName,
    required this.description,
  });
}

class UpdateGroup {
  final int id;
  final String groupName;
  final String description;

  UpdateGroup({
    required this.id,
    required this.groupName,
    required this.description,
  });
}

class DeleteGroup {
  final int groupId;

  DeleteGroup({
    required this.groupId,
  });
}

class GroupListChanged {
  final List<Group> groupList;
  final List<Group> popularGroupList;

  GroupListChanged({
    required this.groupList,
    required this.popularGroupList,
  });
}
