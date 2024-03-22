import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  bool? status;
  String? message;
  Data? data;

  RegisterResponse(
      {this.status, this.message, this.data,});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse (
    status : json['status'],
    message : json['message'],
    data : json['data'] != null ? Data.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String token;

  Data({this.user, required this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user : json['user'] != null ? User.fromJson(json['user']) : null,
    token : json['token'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? fullName;
  String? username;
  String? email;
  String? country;
  String? id;

  User({this.fullName, this.username, this.email, this.country, this.id});

  factory User.fromJson(Map<String, dynamic> json) => User (
    id : json['id'],
    fullName : json['full_name'],
    username : json['username'],
    email : json['email'],
    country : json['country'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['country'] = country;
    data['id'] = id;
    return data;
  }
}
