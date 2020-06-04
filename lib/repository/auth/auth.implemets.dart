import 'dart:convert';
import 'dart:io';

import 'package:ubermove/common/exceptions/excpetions.dart';
import 'package:ubermove/domain/core/base.domain.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/core/api_util.dart';
import 'package:ubermove/network/services/user.dart' as userServices;
import 'package:ubermove/repository/auth/auth.behavior.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository._();

  Future<SuccessLogin> login(String username, String password) async {
    try {
      final response = await userServices.login(username, password);
      final body = json.decode(response.body);
      if (HttpStatus.badRequest == response.statusCode) {
        final error = ErrorResponse.fromJson(body);
        throw LoginException(message: error.message);
      } else if (body['error'] as bool == false &&
          response.statusCode == HttpStatus.ok) {
        final token = body['message'];

        final rawUser = ApiUtil.parseJwt(token);
        print("User: $rawUser");

        return SuccessLogin.fromJson(body);
        // return User.fromJson(rawUser);
      }
      throw LoginException(message: body['message'] ?? body['Message']);
    } on SocketException {
      throw LoginException(message: "Error con el servidor");
    }
  }

  factory AuthRepository.build() {
    // Inject Dependencies
    return AuthRepository._(/* dependencies to be injected */);
  }
  
  Future<User> Registro(User data) async{
    try {
      final response = await userServices.registro(data);
      final body =json.decode(response.body);
      if(HttpStatus.badRequest == response.statusCode)
        throw Exception(ErrorResponse.fromJson(body));
      return body.user;
    }
    on SocketException {
      throw Exception("Error");
    }
  }
}
