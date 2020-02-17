import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../../Funcoes/UserData.dart';
import '../../main.dart';

void main() {
  runApp(Artes());
}

class Artes extends StatefulWidget {
  @override
  ArteState createState() => new ArteState();
}

class ArteState extends State<Artes> {
  String uri = 'https://ae-teste.herokuapp.com';
  var items;
  String jwt;

  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      setState(() {
        this.jwt = jwt;
      });
      this.getData();
    });
  }

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(uri + '/arte'),
        headers: {"Authorization": this.jwt});

    print(response);

    setState(() {
      items = jsonDecode(response.body);
    });
    print(response.body);

    return "Sucesso";
  }

  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: new ListView.builder(
        itemCount: items == null ? 0 : items.length,
        itemBuilder: (BuildContext context, int index) {
          var bg;

          if (items[index]['avatar']['url'] == null) {
            bg = AssetImage("assets/logo.png");
          } else {
            bg = NetworkImage(uri + items[index]['avatar']['url']);
          }
          if(items[index]['nature'] == 'ARTE'){
          return new Container( 
                padding: EdgeInsets.only(bottom: 30),
                child:
           RaisedButton(
             padding: EdgeInsets.all(0),
              color: Colors.white,
              onPressed: () {
      Navigator.pushNamed(
                  context,
                  '/item',
                  arguments: ScreenArguments(
                      items[index]['title'], 
                      items[index]['description'],
                      items[index]['avatar']['url'],
                      DateTime.parse(items[index]['updated_at']),
                      null,
                      items[index]['user_id']
                      // items[index]['steps'],
                  ),
                );
                print('pokebola vai');
              },
              child: Container(
                child: new Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: bg,
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                items[index]['title'],
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              padding: const EdgeInsets.all(20),
                            ),
                            Container(
                              child: Text(
                                items[index]['description'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      )
                      // Text(items[index]['description'])
                    ],
                  ),
                ))));
          } else {
            print('alou');
          }
              
        },
      ),
      floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onPressed: () {Navigator.pushNamed(context, '/itens/form', arguments:"arte");},
          tooltip: 'Criar Arte',
          child: Icon(Icons.add),
        ),
    );
  }
}
