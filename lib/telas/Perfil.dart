import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:ecarto/Construtores/UserArguments.dart';
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:ecarto/Parcial/citacoes.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:ecarto/Widgets/ItensWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PerfilState createState() => new _PerfilState();
}

class _PerfilState extends State<Perfil> {
  GlobalKey globalKey = new GlobalKey();

  String imgUrl = '';
  var loading = true;
  var profile;
  String fetchProfileId;
  var loadQuote;
  var status;
  String id;

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

  getPerfil() async {
    String localId = await void_getID();

    setState(() {
      id = localId;
    });

    String paramId = Get.parameters['id'];
    var user;

    if (paramId == localId) {
      user = await getProfile();
    } else {
      user = await fetchProfile(paramId);
    }

    setState(() {
      loading = false;
      profile = user;
    });
  }

  // Future<void> _captureAndSharePng() async {
  //   try {
  //     RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
  //     var image = await boundary.toImage();
  //     ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();

  //     final tempDir = await getTemporaryDirectory();
  //     final file = await new File('${tempDir.path}/image.png').create();
  //     await file.writeAsBytes(pngBytes);

  //     final channel = const MethodChannel('channel:me.alfian.share/share');
  //     channel.invokeMethod('shareFile', 'image.png');

  //   } catch(e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      await WcFlutterShare.share(
          sharePopupTitle: 'share',
          fileName: 'share.png',
          mimeType: 'image/png',
          bytesOfFile: pngBytes);
      // bytesOfFile: bytes.buffer.asUint8List());

      // final channel = const MethodChannel('channel:me.ecarto.share/share');
      // channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getPerfil2() async {
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

    // final String barcodeId = ModalRoute.of(context).settings.arguments;

    // getThumb().then((value) {
    //   setState(() {
    //     imgUrl = value.toString();
    //   });
    // }).catchError((err) {
    //   print(err);
    // });
    print(Get.parameters['id']);

    getThumb();

    getPerfil();
  }

  fetchId() async {
    var localId = await void_getID();

    setState(() {
      id = localId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    setState(() {
      // loading = false;
      // id = Get.parameters['id'];
    });

    if (loading) {
      return Scaffold(
          body: new Container(
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
                  // Text(
                  //   loadQuote,
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontFamily: 'Montserrat',
                  //       fontSize: 20,
                  //       fontStyle: FontStyle.italic),
                  //   textAlign: TextAlign.center,
                  // )
                ],
              )));
    }

    return Stack(
      overflow: Overflow.visible,
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
                image: (profile['image'] == null || profile['image'] == '')
                    ? imgUrl
                    : profile['image'])
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
              title: new Text(
                "${profile['username']} - ${profile['name']}",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            // drawer: new Drawer(
            //   child: new Container(),
            // ),
            backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[
                new Center(
                  child: new Column(
                    children: <Widget>[
                      new SizedBox(
                        height: _height / 12,
                      ),
                      imgUrl != ''
                          ? new CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius:
                                  _width < _height ? _width / 4 : _height / 4,
                              backgroundImage: NetworkImage(
                                  profile['image'] == null ||
                                          profile['image'] == ''
                                      ? imgUrl
                                      : profile['image']),
                            )
                          : Container(
                              height: 205,
                              width: 205,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                              )),
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
                        profile['instagram'] != null
                            ? profile['instagram']
                            : "",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 35,
                            color: Colors.white),
                      ),

                      new Padding(
                        padding: new EdgeInsets.only(
                            top: _height / 30,
                            left: _width / 8,
                            right: _width / 8),
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

                      profile['id'] == id
                          ? Column(
                              children: [
                                new Divider(
                                  height: _height / 30,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: RaisedButton(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(5),
                                      onPressed: _captureAndSharePng,
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          width: _width / 2.25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.share),
                                              Text('Compartilhar perfil',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ],
                                          ))),
                                ),
                                Center(
                                  child: RepaintBoundary(
                                      key: globalKey,
                                      // child: QrImage(
                                      //   data: id,
                                      //   size: 0.5 * _height,
                                      //   // embeddedImage: AssetImage('assets/logo-colorida.png'),
                                      //   // embeddedImageStyle: QrEmbeddedImageStyle(
                                      //   //   size: Size(80, 80),
                                      //   // ),

                                      //   // onError: (ex) {
                                      //   //   print("[QR] ERROR - $ex");
                                      //   // },
                                      // ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0))),
                                        child: QrImage(
                                          // backgroundColor: Colors.white,
                                          data: profile['id'],
                                          version: QrVersions.auto,
                                          padding: EdgeInsets.all(50),
                                          size: 200.0,
                                          embeddedImage: AssetImage(
                                              'assets/logo-pontos.png'),
                                          embeddedImageStyle:
                                              QrEmbeddedImageStyle(
                                            size: Size(175, 175),
                                          ),
                                        ),
                                      )),
                                ),
                                new Divider(
                                  height: _height / 30,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : Container(),

                      // new Row(
                      //   children: <Widget>[
                      //     rowCell(status[0]['Material'], 'MATERIA', 'IS', 'L'),
                      //     rowCell(status[1]['Artes'], 'ARTE', 'S', '')
                      //   ],
                      // ),
                      new Divider(height: _height / 30, color: Colors.white),
                      id != profile['id']
                          ? ItensWidget(profile)
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Icon(Icons.person,
                                            color: Colors.white),
                                        new SizedBox(
                                          width: _width / 30,
                                        ),
                                        new Text('EDITAR PERFIL',
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    )),
                                // color: Theme.of(context).accentColor,
                                color: Colors.transparent,
                              ),
                            ),

                      new Divider(height: _height / 30, color: Colors.white),

                      id != profile['id'] ?
                      Container() :
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/editPassword');
                        },
                        child: new Container(
                            padding: EdgeInsets.all(40),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(Icons.lock_outline,
                                    color: Colors.white),
                                new SizedBox(
                                  width: _width / 30,
                                ),
                                new Text('EDITAR SENHA',
                                    style: TextStyle(color: Colors.white))
                              ],
                            )),
                        // color: Theme.of(context).accentColor,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                )
              ],
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
