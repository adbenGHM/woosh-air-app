class UserModel {
  String name = '';
  String email = '';
  String? token;

  UserModel({
    this.name = '',
    this.email = '',
    this.token = '',
  });

  UserModel.fromJSON(Map<dynamic, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    token = json['token'];
  }
}
