import 'dart:io' show Platform; //at the top
import 'package:flutter/foundation.dart' show TargetPlatform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'dart:async';
import 'dart:convert';

import 'package:universal_html/prefer_universal/html.dart' as web;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// Define a custom Form widget.
class Cadastro extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<Cadastro> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usuarioCred = TextEditingController();
  final senhaCred = TextEditingController();
  final emailCred = TextEditingController();
  final senhaConfirmaCred = TextEditingController();

  Future<String> cadastroReq() async {
    
    // cloud
    var url = 'https://ae-teste.herokuapp.com';

    // local
    // var url = 'http://localhost:3000';
    
    var endpoint = '/users';
    if (senhaCred.text == senhaConfirmaCred.text) {
      print('req');
      http.Response response =
          await http.post(Uri.encodeFull(url + endpoint), body: {
        'username': usuarioCred.text,
        'email': emailCred.text,
        'password': senhaCred.text
      });
      const bool kIsWeb = identical(0, 0.0);
      var res = jsonDecode(response.body);

      if (res['errors'] == null) {
        SharedPreferences jwt = await SharedPreferences.getInstance();

        print('sucesso');
        http.Response res2 = await http.post(Uri.encodeFull(url + endpoint),
            body: {'email': emailCred.text, 'password': senhaCred.text});
        var login = jsonDecode(res2.body);

        if (kIsWeb) {
          web.window.localStorage['mypref'] = login['token'];
          print('não mobile');
        } else {  
          await jwt.setString('username', usuarioCred.text);
          await jwt.setString('jwt', login['token']);
          print("mobile");
        }

        Navigator.pushNamed(context, '/home');
        

      } else {
        print('erro');
      }

      // print(token);

    } else {
      print('deu ruim');
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              content: Text(
            "A senha e confirmação se diferem",
          ));
        },
      );
    }
    //

    // if (!Platform.isIOS && !Platform.isAndroid) {
    // }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myController.dispose();
    // myController2.dispose();
    usuarioCred.dispose();
    senhaCred.dispose();
    emailCred.dispose();
    senhaConfirmaCred.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              "ECARTO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: usuarioCred,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuário',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: emailCred,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: senhaCred,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: senhaConfirmaCred,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirme sua senha',
              ),
            ),
          ),
          RaisedButton(
            onPressed: cadastroReq,
            color: Colors.lime,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Cadastrar', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),



      // floatingActionButton: FloatingActionButton(
      //   // When the user presses the button, show an alert dialog containing
      //   // the text that the user has entered into the text field.
      //   onPressed: () {
      //     return showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           // Retrieve the text the that user has entered by using the
      //           // TextEditingController.
      //           content: Text("usuário: " +
      //               usuarioCred.text +
      //               "\nEmail" +
      //               emailCred.text),
      //         );
      //       },
      //     );
      //   },
      //   tooltip: 'Show me the value!',
      //   child: Icon(Icons.text_fields),
      // ),



      
    );
  }
}
