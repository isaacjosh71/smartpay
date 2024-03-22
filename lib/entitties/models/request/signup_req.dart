import 'dart:convert';

SendCodeModel sendCodeModelFromJson(String str) => SendCodeModel.fromJson(json.decode(str));

String sendCodeModelToJson(SendCodeModel data) => json.encode(data.toJson());

class SendCodeModel {
  SendCodeModel({
    required this.email,
  });

  final String email;

  factory SendCodeModel.fromJson(Map<String, dynamic> json) => SendCodeModel(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
