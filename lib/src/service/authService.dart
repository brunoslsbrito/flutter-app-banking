import 'dart:convert';

import 'package:FlexPay/src/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthService {
  Future<User> login(TextEditingController email, TextEditingController password) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzeXN0ZW0iLCJ1c2VySWQiOiIxIiwicm9sZSI6IkFETUlOIn0.6sM-QElneAxm4kbexxY3XWj7usWn7hOQ6-6zqYdfk9sZFT1vnVLbFWsZ7U0f_3yjU-dd7fI8N3R5TgFt-GZIMw"
    };
    final String URL = 'https://sistemainterno.maisboleto.com.br:8889/api/user/login';
    String body = '{"login": "' + email.text + '", "password": "' + password.text + '"}';
    Response response = await post(URL, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var user = User.fromJson(json.decode(response.body));
      return user;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Ops! Aconteceu algum problema');
    }
  }

  void signup(TextEditingController nameController, TextEditingController passwordController, TextEditingController emailController, TextEditingController birthController) {}
}
