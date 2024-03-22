
import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) => SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) => json.encode(data.toJson());

class SignupResponseModel {
  bool? status;
  String? message;
  Data? data;

  SignupResponseModel(
      {this.status, this.message, this.data,});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => SignupResponseModel (
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
  String token;

  Data({required this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      token: json["token"],);

      Map<String, dynamic> toJson() => {
        "token": token,
  };
}
