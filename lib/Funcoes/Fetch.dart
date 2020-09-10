import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Funcoes/Utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

alertWidget({String msg = "Aguarde"}) {
 
  var bg = AssetImage("assets/logo-colorida.png");

  return Scaffold(
    backgroundColor: Colors.black54.withOpacity(0.5),
    body: 

  Container(      
      padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //           image: bg,
      //           fit: BoxFit.cover,
      //           colorFilter: new ColorFilter.mode(
      //               Color(0xff42A5F5).withOpacity(0.5),
      //               BlendMode.softLight),
      //         ),
      // ),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              msg,
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            Divider(),
            Container(
              height: 80,
              width: 80,
              child: CircularProgressIndicator()
            )
          ])))
  );
}

Future register(usuario, email, senha, confirmaSenha) async {
  var endpoint = '/auth/register';

  if (senha == confirmaSenha) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    http.Response response = await http.post('$host$endpoint',
        headers : { 'Content-Type': 'application/json' },
        body: json.encode({
          'username': usuario, 
          'email': email, 
          'password': senha
        })
    );


    // const bool kIsWeb = identical(0, 0.0);
    var res = jsonDecode(response.body);

    return res;
  }

  Get.snackbar("Erro", "Senha e confirmação se diferem");
}

Future login(email, senha) async {
  var endpoint = '/auth/login';

  if (senha != null && email != null) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    var response = await http.post('$host$endpoint', 
      headers : { 'Content-Type': 'application/json' },
      body: json.encode({
        "email": email,
        "password": senha
      })
    );
    var res = jsonDecode(response.body);

    Get.back();

    return res;
  }
  Get.snackbar("Atenção", "Deve preeencher com seus dados para continuar");
}

Future newPasswordCall(currentPassword, senha) async {
  var endpoint = '/user/editPassword';
  var jwt = await void_getJWT();

  if (senha != null && currentPassword != null) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    var response = await http.post('$host$endpoint', 
      headers: { 
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $jwt'
      },
      body: json.encode({
        "currentPassword": currentPassword,
        "password": senha
      })
    );
    
    var res = jsonDecode(response.body);

    Get.back();

    return response;
    return res;
  }

  Get.snackbar("Atenção", "Deve preeencher com seus dados para continuar");
}

Future generatePasswordCall(email) async {
  var endpoint = '/user/';
  var jwt = await void_getJWT();

  if (email != null) {
    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    var response = await http.post('$host$endpoint', 
      headers: { 
        'Content-Type': 'application/json',        
      },
      body: json.encode({
        "email": email,        
      })
    );
    
    var res = jsonDecode(response.body);

    Get.back();

    return response;
    return res;
  }

  Get.snackbar("Atenção", "Deve preeencher com seus dados para continuar");
}

handleUnauthorized(){
  Get.toNamed('/login');
}

Future getHomeData() async {
    String endpoint = '/items/list';
    var location = await getLocation();
    var jwt = await void_getJWT();

    String query = '?longitude=${location.longitude}&latitude=${location.latitude}';

    http.Response response = await  http.get(Uri.encodeFull('$host$endpoint$query'), headers: {
      "Authorization": 'Bearer $jwt'
    });
    
    print(response);
    print(response.statusCode);

    if(response.statusCode == 401 || response.statusCode == 503){
      return handleUnauthorized();
    } 

    var res = jsonDecode(response.body);
    
    return res;
    
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
