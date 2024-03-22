import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel{
  RegisterModel({
    required this.email,
    required this.password,
    required this.device_name,
    required this.full_name,
    required this.username,
    required this.country,
  });

  final String email;
  final String password;
  final String device_name;
  final String full_name;
  final String country;
  final String username;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    password: json["password"],
    device_name: json["device_name"],
    full_name: json["full_name"],
    country: json["country"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "device_name": device_name,
    "username": username,
    "country": country,
    "full_name": full_name,
  };
}
