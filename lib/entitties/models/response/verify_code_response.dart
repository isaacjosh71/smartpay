
import 'dart:convert';

VerifyCodeResponse verifyCodeResponseFromJson(String str) => VerifyCodeResponse.fromJson(json.decode(str));

String verifyCodeResponseToJson(VerifyCodeResponse data) => json.encode(data.toJson());

class VerifyCodeResponse {
  bool? status;
  String? message;
  Data? data;

  VerifyCodeResponse(
      {this.status, this.message, this.data,});


  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) => VerifyCodeResponse (
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
  String? email;

  Data({this.email});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],);

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
