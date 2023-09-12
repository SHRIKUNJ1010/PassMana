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
  final Group group;

  UpdateGroup({
    required this.group,
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

  GroupListChanged({
    required this.groupList,
  });
}
