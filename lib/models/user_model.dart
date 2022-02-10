class User_model {
  String userId = "";
  String userName = "";
  String password = "";
  String role = "";

  User_model({
    required this.userId,
    required this.userName,
    required this.password,
    required this.role,
  });

  User_model.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    userName = json['username'];
    password = json['password'];
    role = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userId;
    data['username'] = this.userName;
    data['password'] = this.password;
    data['position'] = this.role;

    return data;
  }
}
