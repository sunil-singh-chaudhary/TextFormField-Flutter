class UserModel {
  String? name, age;
  List<String>? email;
  UserModel({this.name, this.age, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['name'] = name;
    data['age'] = age;
    data['email'] = email;
    return data;
  }
}
