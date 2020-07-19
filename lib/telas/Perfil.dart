import 'dart:collection';
import 'package:transparent_image/transparent_image.dart';
import 'dart:math';

import 'package:ecarto/Construtores/UserArguments.dart';
import 'package:ecarto/Parcial/citacoes.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:http/http.dart' as http;
import 'package:ecarto/Funcoes/UserData.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PerfilState createState() => new _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String imgUrl = '';
  var loading = true;
  var profile;
  var loadQuote;
  var status;
  var id;

  getThumb() async {
    var url = 'https://source.unsplash.com/random/?craft';
    // var url = 'https://dog.ceo/api/breeds/image/random';

    Dio dio = new Dio();

    var response = await dio.get(url);

    print('realUri');
    print(response.realUri);

    setState(() {
      imgUrl = response.realUri.toString();
    });

    return response.realUri;
  }

  getQuote() {
    var length = listCitacoes.length;
    var num = Random().nextInt(length);
    setState(() {
      loadQuote = listCitacoes[num];
    });
  }

  Future<String> getPerfil() async {
    void_getJWT().then((token) async {
      void_getID().then((id) async {
        print(token);

        print('aki');
        print(id);
        Dio dio = new Dio();
        // dio.options.headers['content-Type'] = 'application/json';
        dio.options.headers["authorization"] = token;
        // dio.options.headers["authorization"] = "token ${token}";
        var response = await dio.get(host + '/perfil');
        // print(response);
        print('response.data');
        print(response.data);
        print('response.data');

        setState(() {
          this.id = id;
          profile = response.data[0];
          // loading = false;
          status = [response.data[2], response.data[1]];
        });

        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
              loading = false;
          });
        });

      });
    });

    return 'Sucesso';
  }

  @override
  void initState() {
    super.initState();
    getQuote();
    // getThumb().then((value) {
    //   setState(() {
    //     imgUrl = value.toString();
    //   });
    // }).catchError((err) {
    //   print(err);
    // });

    getThumb();

    var p = getPerfil();

    void_getID().then((id) {
      print('ID USER');
      print(id);
      print('ID USER');
      setState(() {
        id = id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;



    if (loading) {
      return Scaffold(
          body: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    loadQuote,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  )
                ],
              )));
    }

    return new Stack(
      children: <Widget>[
        new Container(
          height: _height,
          color: Theme.of(context).accentColor,
        ),
        imgUrl != ''
            ? FadeInImage.memoryNetwork(              
              height: _height,
              fit: BoxFit.contain,
              placeholder: kTransparentImage,
              image:(profile['image'] == null || profile['image'] == '')
                  ? imgUrl
                  : '$hostImg/uploads/${profile['image']}'
              )
            : CircularProgressIndicator(),
        new BackdropFilter(
            filter: new ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: new Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        new Scaffold(
            appBar: new AppBar(
              brightness: Brightness.dark,
              iconTheme: new IconThemeData(color: Colors.white),
              title: new Text('Perfil', style: TextStyle(color: Colors.white)),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            // drawer: new Drawer(
            //   child: new Container(),
            // ),
            backgroundColor: Colors.transparent,
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: _height / 12,
                  ),
                  imgUrl != ''
                      ? new CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: _width < _height ? _width / 4 : _height / 4,
                          backgroundImage: NetworkImage(
                              profile['image'] == null || profile['image'] == ''
                                  ?
                                  imgUrl
                                  : '$hostImg/uploads/${profile['image']}'),
                        )
                      : Container(
                          height: 205,
                          width: 205,
                          // child: CircularProgressIndicator(
                          //   strokeWidth: 5,
                          // )
                        ),
                  new SizedBox(
                    height: _height / 25.0,
                  ),
                  new Text(
                    profile['name'] != null ? profile['name'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.white),
                  ),
                  new Text(
                    profile['username'] != null ? profile['username'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 30,
                    thickness: 5,
                  ),
                  new Text(
                    profile['email'] != null ? profile['email'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 35,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  new Text(
                    profile['phone'] != null ? profile['phone'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 35,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  new Text(
                    profile['instagram'] != null ? profile['instagram'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 35,
                        color: Colors.white),
                  ),
                  new Text(
                    profile['pinterest'] != null ? profile['pinterest'] : "",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 35,
                        color: Colors.white),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: new Text(
                      profile['about'] != null
                          ? profile['about']
                          : 'Sobre mim... ',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Divider(
                    height: _height / 30,
                    color: Colors.white,
                  ),
                  new Row(
                    children: <Widget>[
                      rowCell(status[0]['Material'], 'MATERIA', 'IS', 'L'),
                      rowCell(status[1]['Artes'], 'ARTE', 'S', '')
                    ],
                  ),
                  new Divider(height: _height / 30, color: Colors.white),
                  id.toString() != profile['id'].toString()
                      ? Padding(
                          padding: new EdgeInsets.only(
                              left: _width / 8, right: _width / 8),
                          child: new FlatButton(
                            onPressed: () {
                              print('a implementar');
                            },
                            child: new Container(
                                child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(Icons.person),
                                new SizedBox(
                                  width: _width / 30,
                                ),
                                new Text('SEGUIR')
                              ],
                            )),
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      : Padding(
                          padding: new EdgeInsets.only(
                              left: _width / 8, right: _width / 8),
                          child: new FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/formperfil',
                                  arguments: UserArguments(
                                    profile['id'],
                                    profile['name'],
                                    profile['username'],
                                    profile['email'],
                                    profile['phone'],
                                    profile['instagram'],
                                    profile['pinterest'],
                                    profile['about'],
                                    profile['image'],
                                  ));
                            },
                            child: new Container(
                                padding: EdgeInsets.all(40),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(Icons.person, color: Colors.white),
                                    new SizedBox(
                                      width: _width / 30,
                                    ),
                                    new Text('EDITAR PERFIL',
                                        style: TextStyle(color: Colors.white))
                                  ],
                                )),
                            // color: Theme.of(context).accentColor,
                            color: Colors.transparent,
                          ),
                        ),
                ],
              ),
            ))
      ],
    );
  }

  Widget rowCell(int count, String type, String sufixoP, String sufixoS) =>
      new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            '$count',
            style: new TextStyle(color: Colors.white),
          ),
          new Text('$type${count > 1 ? sufixoP : sufixoS}',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return null;
}
