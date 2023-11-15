class AdminModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNo;
  String? dist;

  AdminModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNo,
    this.dist,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    String? uid = json['uid'];
    String? name = json['name'];
    String? email = json['email'];
    String? phoneNo = json['phoneNo'];
    String? dist = json['dist'];
    return AdminModel(
      uid: uid,
      name: name,
      email: email,
      phoneNo: phoneNo,
      dist: dist,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['dist'] = dist;
    return data;
  }
}
