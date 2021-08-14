class LoginModel {
  bool status;
  String message;
  UserModel data;

  LoginModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    status = map['status'];
    message = map['message'];
    data = map['data'] != null ? UserModel.fromJson(map['data']) : null;
  }

  toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}

class UserModel {
  int id;
  String email, name, password, image, phone, token;

  UserModel(this.password, this.image, this.phone,
      {this.email, this.id, this.name, this.token});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    email = map['email'];
    password = map['password'];
    name = map['name'];
    image = map['image'];
    phone = map['phone'];
    token = map['token'];
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
      'phone': phone,
      'token': token,
    };
  }
}
