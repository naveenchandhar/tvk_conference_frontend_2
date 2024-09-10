// To parse this JSON data, do
//
//     final loginError = loginErrorFromJson(jsonString);

import 'dart:convert';

LoginError loginErrorFromJson(String str) => LoginError.fromJson(json.decode(str));

String loginErrorToJson(LoginError data) => json.encode(data.toJson());

class LoginError {
  String error;

  LoginError({
    required this.error,
  });

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
