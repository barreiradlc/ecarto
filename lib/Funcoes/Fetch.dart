import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Recursos/Api.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
// print(host);

Future<http.Response> fetchPost() async {
  http.Response response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  print('response');
  print(response);

  return response;
}

alertWidget() {
  var bg = AssetImage("assets/logo.png");

  return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bg,
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.green.withOpacity(0.6), BlendMode.srcOver),
        ),
      ),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Aguarde',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            Divider(),
            CircularProgressIndicator()
          ])));
}

Future register(usuario, email, senha, confirmaSenha) async {
  var endpoint = '/users';

  if (senha == confirmaSenha) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    http.Response response = await http.post(Uri.encodeFull(host + endpoint),
        body: {'username': usuario, 'email': email, 'password': senha});

    const bool kIsWeb = identical(0, 0.0);
    var res = jsonDecode(response.body);

    return res;

    // tratar erro
    // if erro (alert())
    // else login
    // funçao de login
    // salvar id, jwt e usename
    // redirect para home

  }

  Get.snackbar("Erro", "Senha e confirmação se diferem");
}

Future login(email, senha) async {
  var endpoint = '/auth/login';

  if (senha != null && email != null) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    http.Response response =
        await http.post(Uri.encodeFull(host + endpoint), body: {
      // 'username': usuarioCred.text,
      'email': email,
      'password': senha
    });
    const bool kIsWeb = identical(0, 0.0);
    var res = jsonDecode(response.body);

    Get.back();

    return res;
  }
  Get.snackbar("Atenção", "Deve preeencher com seus dados para continuar");
}

// Future<http.Response> fetchPost() async {
//   final http.Response response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     // print(response);
//     return json.decode(response.body);
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }
