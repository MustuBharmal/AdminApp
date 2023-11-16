class AdminModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNo;
  String? dist;
  String? role;

  AdminModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNo,
    this.dist,
    this.role,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    String? uid = json['uid'];
    String? name = json['name'];
    String? email = json['email'];
    String? phoneNo = json['phoneNo'];
    String? dist = json['dist'];
    String? role = json['role'];
    return AdminModel(
      uid: uid,
      name: name,
      email: email,
      phoneNo: phoneNo,
      dist: dist,
      role: role,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['dist'] = dist;
    data['role'] = role;
    return data;
  }
}
