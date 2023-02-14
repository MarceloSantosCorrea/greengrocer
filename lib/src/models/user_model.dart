import 'dart:convert';

class UserModel {
  String? id;
  String? token;
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;

  UserModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (token != null) {
      result.addAll({'token': token});
    }
    if (name != null) {
      result.addAll({'fullname': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (password != null) {
      result.addAll({'password': password});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      token: map['token'],
      name: map['fullname'],
      email: map['email'],
      phone: map['phone'],
      cpf: map['cpf'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, token: $token, name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password)';
  }
}
