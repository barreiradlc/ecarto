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
  
  final usuarioCred = TextEditingController(text: '');
  final emailCred = TextEditingController(text: '');
  final senhaCred = TextEditingController(text: '');
  final senhaConfirmaCred = TextEditingController(text: '');
  
  // final usuarioCred = TextEditingController(text: 'elBarrero');
  // final emailCred = TextEditingController(text: 'barreira234@hotmail.com');
  // final senhaCred = TextEditingController(text: '123123');
  // final senhaConfirmaCred = TextEditingController(text: '123123');

  Future cadastroReq() async {
    register(usuarioCred.text, emailCred.text, senhaCred.text,
            senhaConfirmaCred.text)
        .then((res) {
      if (res['errors'] != null) {
        print(res);

        var index = 1;
        res['errors'].forEach((item) async => Get.snackbar("Erro", item,
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
      
        // appBar: AppBar(
        //   iconTheme: new IconThemeData(color: Colors.white),
        //   title: Text('Cadastro', style: TextStyle(color: Colors.white)),
        // ),
        body: 
        SingleChildScrollView(
          child: 
          
        
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Transform.scale(
              scale: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 60),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                // padding: new EdgeInsets.all(2.0),
                
                child: Hero(
                  tag: "LogoHome",
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  )
                )
              
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                      controller: usuarioCred,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        labelText: 'Usuário',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                      controller: emailCred,
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
                    
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                      controller: senhaCred,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        labelText: 'Senha',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      textInputAction: TextInputAction.done,                      
                      controller: senhaConfirmaCred,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        labelText: 'Confirme sua senha',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: RaisedButton(
                      onPressed: cadastroReq,                      
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Cadastrar',
                            style:
                                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor,)),
                      ),
                    ),
                  ),
                  Divider(
                    height: 24,
                  ),

                  // margin: const EdgeInsets.only(left: 20.0, right: 20.0),

                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    color: Colors.white,
                    
                    child: Text('Já sou cadastrado, fazer login',
                        style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor,)),
                  ),
                ],
              ),
            )
          ],
        )
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
