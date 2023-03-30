class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.isValidated,
  });
  late final int id;
  late final String username;
  late final String email;
  late final String password;
  late final bool isValidated;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    isValidated = json['isValidated'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['password'] = password;
    _data['isValidated'] = isValidated;
    return _data;
  }
}