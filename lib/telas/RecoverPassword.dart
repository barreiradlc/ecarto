import 'dart:io' show Platform; //at the top
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

import 'package:universal_html/prefer_universal/html.dart' as web;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// Define a custom Form widget.
class RecoverPassword extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<RecoverPassword> {
  @override
  void initState() {
    super.initState();
  }

  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final myController = TextEditingController(text: '');
  final myController2 = TextEditingController(text: '');

  // final myController = TextEditingController(text: 'barreiro26@hotmail.com');
  // final myController2 = TextEditingController(text: '213123');

  // final myController = TextEditingController(text: 'elBarrero');
  // final myController2 = TextEditingController(text: '123123');

  alertAviso(msg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text(
          msg,
        ));
      },
    );
  }

  getReq() async {
    var response = await generatePasswordCall(myController.text);

    if(response.statusCode != 200){
      return Get.snackbar("Usuário não encontrato", "Email não cadastrado no sistema");
    }

    Get.toNamed('/login');      

    return Get.snackbar("Nova senha solicitada com sucesso!", "Aguarde no email pelos próximos passos");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: Text(
          //     "E-PROJ",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
          //   ),
          // ),
          Transform.scale(
            scale: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 60),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              // padding: new EdgeInsets.all(2.0),
              // color: Colors.white,                              
                child: Hero(
                  tag: "LogoHome",
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  )
                )
              
            ),
          ),
          //
          // Form
          //
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                      controller: myController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                  
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                      onPressed: getReq,                      
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Text('Recuperar senha',
                            style:
                                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor )),
                      ),
                    ),
                  ),
                ]),
          ),

          //
          // Form
          //

          Padding(
            // margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            padding: const EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(                  
                    'Retornar ao login',
                    style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor)),
              ),
            ),
          ),

          // ÍCONES SOCIAIS

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     IconButton(
          //         // Use the FontAwesomeIcons class for the IconData
          //         icon: new Icon(FontAwesomeIcons.googlePlus),
          //         onPressed: () {
          //           print("Pressed");
          //           return showDialog(
          //             context: context,
          //             builder: (context) {
          //               return AlertDialog(
          //                 // Retrieve the text the that user has entered by using the
          //                 // TextEditingController.
          //                 content: Text("Funcionalidade em Desenvolvimento"),
          //               );
          //             },
          //           );
          //         }),
          //     IconButton(
          //         // Use the FontAwesomeIcons class for the IconData
          //         icon: new Icon(FontAwesomeIcons.facebook),
          //         onPressed: () {
          //           return showDialog(
          //             context: context,
          //             builder: (context) {
          //               return AlertDialog(
          //                 // Retrieve the text the that user has entered by using the
          //                 // TextEditingController.
          //                 content: Text("Funcionalidade em Desenvolvimento"),
          //               );
          //             },
          //           );
          //         })
          //   ],
          // )

          // ÍCONES SOCIAIS
        ],
      ),
    );
  }
}
