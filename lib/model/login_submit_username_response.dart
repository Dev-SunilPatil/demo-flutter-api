class LoginSubmitUsernameVo {

  bool? loginCodeIsRequired;
  String? responseDateTime;

  LoginSubmitUsernameVo.fromJson(dynamic json) {
    loginCodeIsRequired = json['LoginCodeIsRequired'];
    responseDateTime = json['ResponseDateTime'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LoginCodeIsRequired'] = loginCodeIsRequired;
    map['ResponseDateTime'] = responseDateTime;
    return map;
  }

}