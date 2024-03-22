import 'dart:convert';

VerifyCodeModel verifyCodeModelFromJson(String str) => VerifyCodeModel.fromJson(json.decode(str));

String verifyCodeModelToJson(VerifyCodeModel data) => json.encode(data.toJson());

class VerifyCodeModel {
  VerifyCodeModel({
    required this.email,
    required this.token,
  });

  final String email;
  final String token;

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) => VerifyCodeModel(
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
  };
}
