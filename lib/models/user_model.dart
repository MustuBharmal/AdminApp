class UsersModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNo;
  String? dist;
  String? state;
String? role;
  UsersModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNo,
    this.dist,
    this.state,
    this.role,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    String? uid = json['uid'];
    String? name = json['name'];
    String? email = json['email'];
    String? phoneNo = json['phoneNo'];
    String? dist = json['dist'];
    String? state = json['state'];
    String? role = json['role'];
    return UsersModel(
      uid: uid,
      name: name,
      email: email,
      phoneNo: phoneNo,
      dist: dist,
      state: state,
        role:role,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['dist'] = dist;
    data['state'] = state;
    data['role'] = role;
    return data;
  }
}
