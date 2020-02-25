import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../../Funcoes/UserData.dart';
import '../../main.dart';

class Artes extends StatefulWidget {
  final artes;
  Artes(this.artes);

  @override
  ArteState createState() => new ArteState();
}

class ArteState extends State<Artes> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';

    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: new ListView.builder(
        itemCount: widget.artes == null ? 0 : widget.artes.length,
        itemBuilder: (BuildContext context, int index) {
          var bg;

          if (widget.artes[index]['avatar'] != null) {            
            if (widget.artes[index]['avatar']['url'] == null) {
              bg = AssetImage("assets/logo.png");
            } else {
              bg = NetworkImage(host + widget.artes[index]['avatar']['url']);
            }
          } else {
            bg = AssetImage("assets/logo.png");
          }

          if (widget.artes[index]['nature'] == 'ARTE') {
            return new Container(
                padding: EdgeInsets.only(bottom: 30),
                child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/item',
                        arguments: ScreenArguments(
                            widget.artes[index]['title'],
                            widget.artes[index]['description'],
                            widget.artes[index]['avatar']['url'],
                            DateTime.parse(widget.artes[index]['updated_at']),
                            null,
                            widget.artes[index]['user_id']
                            // widget.artes[index]['steps'],
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
                                    Colors.blue.withOpacity(0.6),
                                    BlendMode.dstATop),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.artes[index]['title'],
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
                                    widget.artes[index]['description'],
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
                          // Text(widget.artes[index]['description'])
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
        onPressed: () {
          Navigator.pushNamed(context, '/itens/form', arguments: "arte");
        },
        tooltip: 'Criar Arte',
        child: Icon(Icons.add),
      ),
    );
  }
}
