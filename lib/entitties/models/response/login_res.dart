import 'dart:convert';

LogInResponseModel logInResponseModelFromJson(String str) => LogInResponseModel.fromJson(json.decode(str));

String logInResponseModelToJson(LogInResponseModel data) => json.encode(data.toJson());

class LogInResponseModel {
  bool? status;
  String? message;
  Data? data;

  LogInResponseModel(
      {this.status, this.message, this.data,});


  factory LogInResponseModel.fromJson(Map<String, dynamic> json) => LogInResponseModel (
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

  Data({required this.user, required this.token});

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
  String? id;
  String? fullName;
  String? username;
  String? email;
  String? country;

  User(
      {this.id,
        this.fullName,
        this.username,
        this.email,
        this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => User (
    id : json['id'],
    fullName : json['full_name'],
    username : json['username'],
    email : json['email'],
    country : json['country'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['country'] = country;
    return data;
  }
}
