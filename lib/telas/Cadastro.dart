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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      "Aguarde...",
                    )
                  ],
                )));
      },
    );
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
        endpoint = '/auth/login';
        SharedPreferences jwt = await SharedPreferences.getInstance();

        print('sucesso');
        http.Response res2 = await http.post(Uri.encodeFull(url + endpoint),
            body: {'email': emailCred.text, 'password': senhaCred.text});
        var login = jsonDecode(res2.body);

        if (kIsWeb) {
          web.window.localStorage['mypref'] = login['token'];
          
          print('não mobile');
        } else {
          await jwt.setString('jwt', login['token']);
          print('sucesso1');
          await jwt.setString('username', login['username']);
          print('sucesso2');
          await jwt.setString('id', login['id'].toString());
          print('sucesso3');

          print("mobile");
        }

        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pop(context);
        print('erro');
        var erros = jsonDecode(response.body);
        print(erros['errors']);
        print(erros['errors'][0]);
        return showDialog(
          context: context,
          builder: (context) {
            // if (erros['errors'][0] == "Email is invalid") {
            //   return AlertDialog(
            //       // Retrieve the text the that user has entered by using the
            //       // TextEditingController.
            //       content: Container(
            //     padding: EdgeInsetsDirectional.only(top: 50),
            //     height: 150,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           "Erro: \n",
            //         ),
            //         Text(
            //           "Email Inválido",
            //         )
            //       ],
            //     ),
            //   ));
            // }
            // if (erros['errors'][0] == "Password is too short (minimum is 6 characters)") {
            //   return AlertDialog(
            //       // Retrieve the text the that user has entered by using the
            //       // TextEditingController.
            //       content: Container(
            //     padding: EdgeInsetsDirectional.only(top: 50),
            //     height: 150,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           "Erro: \n",
            //         ),
            //         Text(
            //           "Senha muito curta mínimo de 6 dígitos",
            //         )
            //       ],
            //     ),
            //   ));
            // }
              return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Erro: \n",
                    ),
                    Text(
                      erros[0],
                    )
                  ],
                ),
              ));
          },
        );
      }

      // print(token);
    } else {
      Navigator.pop(context);
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
            Transform.scale(
              scale: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                // padding: new EdgeInsets.all(2.0),
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: <Widget>[
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: RaisedButton(
                      onPressed: cadastroReq,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Text('Cadastrar', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
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
