import 'package:equatable/equatable.dart';

class ErrorResponse {
  final String code;
  final bool error;
  final String message;

  ErrorResponse({this.code, this.error, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'],
      error: json['error'],
      message: json['message'] ?? json['Message'],
    );
  }
}

class SuccessLogin extends ErrorResponse {
  final String token;
  SuccessLogin({this.token, String code, bool error})
      : super(error: error, message: null, code: code);

  factory SuccessLogin.fromJson(Map<String, dynamic> json) {
    return SuccessLogin(
      code: json['code'],
      error: false,
      token: json['message'],
    );
  }
}

abstract class Entity extends Equatable {
  const Entity();

  Map<String, dynamic> convertirJson();
}
