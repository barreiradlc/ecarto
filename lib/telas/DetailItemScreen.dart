import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:e_carto/Funcoes/UserData.dart';
import 'package:e_carto/Parcial/Carousel.dart';
import 'package:e_carto/Parcial/MateriaisList.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../main.dart';

import 'package:intl/intl.dart';

class DetailItemScreen extends StatefulWidget {
  @override
  DetailItems createState() => new DetailItems();
}

class DetailItems extends State<DetailItemScreen> {
  var autor;
  var jwt;
  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      print(jwt);
      setState(() {
        jwt = jwt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var todo = ModalRoute.of(context).settings.arguments;
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;
    String formatDate(DateTime date) =>
        new DateFormat("MMMM d").format(item.updated_at);
    String update = DateFormat('dd/MM/y kk:mm').format(item.updated_at);

    var thumb;
    var passoAPasso;
    thumb = Image.asset('assets/logo.png');

    if (item.thumbnail != null) {
      thumb = Image.network(host + item.thumbnail,
          fit: BoxFit.cover, alignment: Alignment.center);
    }

    alertAutor() {
      print('autor');
      print(autor['email']);
      print('autor');
      // print(autor.email);
      return showDialog(
          context: context,
          builder: (context) {
            return Container(
              height: 60,
              child: AlertDialog(
                content: Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    autor['name'] != null?
                      ListTile(
                        title: Text('Nome:' + autor.name),
                      ) :  Container(),

                    autor['phone'] != null
                        ? ListTile(
                            title: Text('Telefone:' + autor['phone']),
                          )
                        :  Container(),

                    autor['email'] != null
                        ? ListTile(
                            title: Text('Email: ' + autor['email']),
                          )
                        :  Container(),

                    autor['instagram'] != null
                        ? ListTile(
                            title: Text('Instagram:'),
                          )
                        :  Container(),

                    autor['pinterest'] != null
                        ? ListTile(
                            onTap: () => print('object'),
                            title: Text('Pinterest:'),
                          )
                        : Container()
                  ],
                )),
              ),
            );
          });
    }

    Future<String> contatarAutor(id) async {
      void_getJWT().then((token) async {
        print(token);
        print(id.toString());
        Dio dio = new Dio();
        // dio.options.headers['content-Type'] = 'application/json';
        dio.options.headers["authorization"] = token;
        // dio.options.headers["authorization"] = "token ${token}";
        var response = await dio.get(host + '/usuario/' + id.toString());
        // print(response);
        print('response.data');
        print(response.data);
        print('response.data');

        setState(() {
          autor = response.data;
        });
      });

      // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
      //     headers: {"Authorization": jwt});

      // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
      //   headers: {"Authorization": jwt});

      // Response response;
      // Dio dio = new Dio();
      // response = await dio.get("/test?id=12&name=wendu");
      // print(response.data.toString());
// Optionally the request above could also be done as
      // response =
      //     await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
      // print(response.data.toString());

      // print(jsonDecode(response.body));
      // print(response.body);

      // print(response.body);

      alertAutor();

      return "Sucesso";
    }

    // if (item.steps.length != 0) {
    //   passoAPasso = RaisedButton(
    //     padding: EdgeInsets.all(20),
    //     onPressed: () {
    //       showFancyCustomDialog(context);
    //     },
    //     color: Colors.white,
    //     child: Text("Passo a passo"),
    //   );
    // } else {
    //   passoAPasso = RaisedButton(
    //       padding: EdgeInsets.all(20),
    //       onPressed: () {
    //         // showFancyCustomDialog(context);
    //       },
    //       color: Colors.white70,
    //       child: Text("Passo a passo indisponível",
    //           style: TextStyle(color: Colors.white)));
    // }

    // print(item.steps[0]);

    // Use the item to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: new ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(height: 250.0, child: thumb),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(item.description), //
            ),
            Container(
                child: RaisedButton(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chat),
                        Text("Contatar autor")
                      ],
                    ),
                    onPressed: () => contatarAutor(item.user_id))),
            // MateriaisList(),
            // passoAPasso,
            Container(
              alignment: Alignment(1.0, 1.0),
              padding: EdgeInsets.fromLTRB(5, 45, 5, 5),
              child: Text("Última atualização em: " + update), //
            )
          ])),
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;

    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: CarouselList(item.steps),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Fechar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(0.9, -0.9),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }
}

//  NetworkImage(host + item.thumbnail)
