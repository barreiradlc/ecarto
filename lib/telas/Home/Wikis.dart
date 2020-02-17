import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../../Funcoes/UserData.dart';
import '../../main.dart';

void main() {
  runApp(Wikis());
}

class Wikis extends StatefulWidget {
  @override
  WikiState createState() => new WikiState();
}

class WikiState extends State<Wikis> {
  String uri = 'https://ae-teste.herokuapp.com';
  var wikis;
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
    var response = await http.get(Uri.encodeFull(uri + '/wikis'),
        headers: {"Authorization": this.jwt});

    setState(() {
      wikis = jsonDecode(response.body);
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
        itemCount: wikis == null ? 0 : wikis.length,
        itemBuilder: (BuildContext context, int index) {
          var bg;

          if (wikis[index]['avatar']['url'] == null) {
            bg = AssetImage("assets/logo.png");
          } else {
            bg = NetworkImage(uri + wikis[index]['avatar']['url']);
          }

          return new Container(
              padding: EdgeInsets.only(bottom: 30),
              child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  onPressed: () {
                    // When the user taps the button, navigate to a named route
                    // and provide the arguments as an optional parameter.
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: ScreenArguments(
                        wikis[index]['title'],
                        wikis[index]['description'],
                        wikis[index]['avatar']['url'],
                        DateTime.parse(wikis[index]['updated_at']),
                        wikis[index]['steps'],
                        null,
                      ),
                    );
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
                                  wikis[index]['title'],
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
                                  wikis[index]['description'],
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
                        // Text(wikis[index]['description'])
                      ],
                    ),
                  ))));
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     // When the user presses the button, show an alert dialog containing
      //     // the text that the user has entered into the text field.
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.green,
      //     onPressed: () {Navigator.pushNamed(context, '/wiki/form');},
      //     tooltip: 'Criar Wiki',
      //     child: Icon(Icons.add),
      //   ),
    );
  }
}
