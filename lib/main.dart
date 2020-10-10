import 'dart:io';

import 'package:ecarto/telas/Chat.dart';
import 'package:flutter/services.dart';

import 'package:ecarto/telas/DetailScreen.dart';
import 'package:ecarto/telas/EstoquePage.dart';
import 'package:ecarto/telas/Etapas.dart';
import 'package:ecarto/telas/NewWikiPage.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

// telas
import './telas/Home.dart';
import './telas/Login.dart';
import './telas/Cadastro.dart';
// import  './telas/Camera.dart';
import 'package:ecarto/telas/Home/ExtractArgumentsScreen.dart';

import 'telas/ChatRoom.dart';
import 'telas/Perfil/FormPerfilPage.dart';
import 'telas/Perfil/ChangePassword.dart';
import './Funcoes/UserData.dart';
import 'telas/DetailItemScreen.dart';
import 'telas/Itens/Form.dart';
import 'telas/Perfil.dart';
import 'telas/RecoverPassword.dart';
import 'telas/ScanScreen.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = new MyHttpOverrides();

  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Splash Screen Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
  var editPassword = new ChangePassword();
  var recoverPassword = new RecoverPassword();
  var scanScreen = new ScanScreen();

  var formItem = new FormItemPage();
  var formWiki = new FormWikiPage();
  var formSteps = new Etapas();
  // var tutorial = new Tutorial();
  // var camera = new Camera();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor:
            Colors.transparent, //or set color with: Color(0xFF0000FF)
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));

    if (this.homePage == '') {
      return CircularProgressIndicator();
    }

    return GetMaterialApp(
      theme: ThemeData(
        // primaryColor: Colors.blue,
        // accentColor: Colors.green,

        highlightColor: Colors.white,
        primaryColorLight: Colors.white,

        accentIconTheme: new IconThemeData(color: Colors.white),
        primaryColor: Color(0xff42A5F5),
        accentColor: Color(0xff558b2f),

        // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
        fontFamily: 'Roboto',
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(brightness: Brightness.light),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: this.homePage,
      
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/home': (context) => inicio,

        // When navigating to the "/second" route, build the SecondScreen widget.


        '/details': (context) => detalhes,
        '/item': (context) => item,
        '/estoque': (context) => estoque,
        // '/perfil': (context) => perfil,
        '/formperfil': (context) => formperfil,
        '/editPassword': (context) => editPassword,
        '/recoverPassword': (context) => recoverPassword,
        '/scanScreen': (context) => scanScreen,

        '/itens/form': (context) => formItem,

        '/wiki/form': (context) => formWiki,
        '/steps/form': (context) => formSteps,

        // '/login': (context) => login,
        '/cadastro': (context) => cadastro,
        // '/camera': (context) => camera,
      },
      getPages: [
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/login', page: () => Login() ),        
        GetPage(name: '/perfil/:id', page: () => Perfil() ),
        GetPage(name: '/chat/:id', page: () => ChatRoom() ),
        GetPage(name: '/chat', page: () => Chat() )
      ],
    );
  }
}

class Inicio {}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.white30,
            // Color(0xffED213A),
            // Color(0xff93291E)
          ],
        ),
        navigateAfterSeconds: HomeScreen(),
        loaderColor: Colors.transparent,
      ),
      Center(
        child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(50),
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white30,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              // image: DecorationImage(
              //   image: AssetImage("assets/logo-colorida.png"),
              //   fit: BoxFit.contain,
              // ),
            ),
            child: Image.asset("assets/logo.png")),
      )
    ],
  );
}
