import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  Future<http.Response> signUpUser(User user) async {
    try {
      http.Response res = await http.post(Uri.parse(signUpUrl),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> signInUser(String email, String password) async {
    return await http.post(
      Uri.parse(signInUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }

  Future<http.Response> isTokenValid({required var token}) async {
    try {
      http.Response res =
          await http.get(Uri.parse(isTokenValidUri), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
