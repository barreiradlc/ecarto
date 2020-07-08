import 'package:ecarto/telas/DetailScreen.dart';
import 'package:ecarto/telas/EstoquePage.dart';
import 'package:ecarto/telas/Etapas.dart';
import 'package:ecarto/telas/NewWikiPage.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// telas
import './telas/Home.dart';
import './telas/Login.dart';
import './telas/Cadastro.dart';
// import  './telas/Camera.dart';
import 'package:ecarto/telas/Home/ExtractArgumentsScreen.dart';

import 'telas/Perfil/FormPerfilPage.dart';
import './Funcoes/UserData.dart';
import 'telas/DetailItemScreen.dart';
import 'telas/Itens/Form.dart';
import 'telas/Perfil.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new Geral());
}

class Geral extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<Geral> {
  String jwt = '';
  String homePage = '';

  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      

      if (jwt == null) {
        homePage = '/login';
      } else {
        homePage = '/home';
      }
      print(jwt);
      setState(() {
        this.jwt = jwt;
        this.homePage = homePage;
        // this.username = username;
      });
    });
  }

  var inicio = new Home();
  var login = new Login();
  var cadastro = new Cadastro();
  var detalhes = new DetailScreen();
  var item = new DetailItemScreen();
  var estoque = new EstoquePage();
  var perfil = new Perfil();
  var formperfil = new FormPerfilPage();

  var formItem = new FormItemPage();
  var formWiki = new FormWikiPage();
  var formSteps = new Etapas();
  // var tutorial = new Tutorial();
  // var camera = new Camera();

  @override
  Widget build(BuildContext context) {

    if (this.homePage == '') {
      return CircularProgressIndicator();
    }

    return GetMaterialApp(
      color: Colors.lightBlue,
      theme: ThemeData(     
           
        primaryColor: Color(0xff00999b),                
        accentColor: Color(0xffb3e848),
        
        // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: this.homePage,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => inicio,

        // When navigating to the "/second" route, build the SecondScreen widget.

        '/details': (context) => detalhes,
        '/item': (context) => item,
        '/estoque': (context) => estoque,
        '/perfil': (context) => perfil,
        '/formperfil': (context) => formperfil,

        '/itens/form': (context) => formItem,

        '/wiki/form': (context) => formWiki,
        '/steps/form': (context) => formSteps,
        
        '/login': (context) => login,
        '/cadastro': (context) => cadastro,
        // '/camera': (context) => camera,
      },
    );
  }
}
