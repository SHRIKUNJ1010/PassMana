/*
Created By Shrikunj on 03/01/25
*/

class CardSecurityGridNumberList {
  List<SecurityGridNumber>? securityGridNumerList;

  CardSecurityGridNumberList({
    this.securityGridNumerList = const [],
  });

  CardSecurityGridNumberList.fromJson(Map<String, dynamic> json) {
    if (json['security_grid_list'] != null) {
      securityGridNumerList = <SecurityGridNumber>[];
      json['security_grid_list'].forEach((v) {
        securityGridNumerList?.add(SecurityGridNumber.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['security_grid_list'] = securityGridNumerList;
    return data;
  }
}

class SecurityGridNumber {
  String? title;
  String? value;

  SecurityGridNumber({
    this.title = '',
    this.value = '',
  });

  SecurityGridNumber.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    value = json['value'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title ?? "";
    data['value'] = value ?? "";
    return data;
  }
}
