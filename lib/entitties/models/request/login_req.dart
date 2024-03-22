import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel{
  LoginModel({
    required this.email,
    required this.password,
    required this.device,
  });

  final String email;
  final String password;
  final String device;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    email: json["email"],
    password: json["password"],
    device: json["device_name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "device_name": device,
  };
}
