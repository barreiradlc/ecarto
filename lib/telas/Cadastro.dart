import 'dart:async';

import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final usuarioCred = TextEditingController(text: 'gustin');
  final emailCred = TextEditingController(text: 'augustodasilva53@gmail.com');
  final senhaCred = TextEditingController(text: '123123');
  final senhaConfirmaCred = TextEditingController(text: '123123');

  Future cadastroReq() async {
    register(
      usuarioCred.text, 
      emailCred.text, 
      senhaCred.text,
      senhaConfirmaCred.text)        
      .then((res) {
      if (res['errors'] != null) {

        print(res);

        var index = 1;
        res['errors']
            .forEach((item) async => Get.snackbar("Erro", item,
                margin: EdgeInsets.only(top: 50.0 * ++index),
                animationDuration: Duration(seconds: 1 * ++index)));

        return Get.back();
      } else {
        Get.snackbar("Sucesso", "Usuário cadastrado com sucesso");

        login(emailCred.text, senhaCred.text).then((res2) {
          setLoginData(res2).then((response) {
            print('response');
            print(response);

            Navigator.pushReplacementNamed(context, '/home');
          }).catchError((err) {
            print(err);
          });
        }).catchError((err) {
          return Get.snackbar(
              "Erro de conexão", "Não foi possível conectar ao servidor");
        });
      }
    }).catchError((err) {
      print('Erro');
      print(err);
      Get.back();
      return Get.snackbar(
          "Erro de conexão", "Não foi possível conectar ao servidor");

      // dialogoAlertaLista(err['errors'], context);
    });

    // Navigator.pop(context);

    // checar id
    // tratar erro
    // if erro (alert())
    // else login
    // funçao de login
    // salvar id, jwt e usename
    // redirect para home
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
                        child: Text('Cadastrar',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  Divider(
                    height: 40,
                  ),
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
                            'Já sou cadastrado, fazer login',
                            style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ),
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
