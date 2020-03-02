import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../../Funcoes/UserData.dart';
import '../../main.dart';

class Materiais extends StatefulWidget {
  final materiais;
  Materiais(this.materiais);

  @override
  MateriaiState createState() => new MateriaiState();
}

class MateriaiState extends State<Materiais> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {



    // if (widget.materiais.length == 0) {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    return Scaffold(
      body: new ListView.builder(
        itemCount: widget.materiais == null ? 0 : widget.materiais.length,
        itemBuilder: (BuildContext context, int index) {
          var bg;

          if (widget.materiais[index]['avatar']['url'] == null) {
            bg = AssetImage("assets/logo.png");
          } else {
            bg = NetworkImage(host + widget.materiais[index]['avatar']['url']);
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
                      '/item',
                      arguments: ScreenArguments(
                          widget.materiais[index]['title'],
                          widget.materiais[index]['description'],
                          widget.materiais[index]['avatar']['url'],
                          DateTime.parse(widget.materiais[index]['updated_at']),
                          null,
                          widget.materiais[index]['user_id'],
                          // widget.materiais[index]['steps'],
                          ),
                    );
                    // print('pokebola vai');
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
                                  widget.materiais[index]['title'],
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
                                  widget.materiais[index]['description'],
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
                        // Text(widget.materiais[index]['description'])
                      ],
                    ),
                  ))));
        },
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/itens/form', arguments: "material");
        },
        tooltip: 'Criar Material',
        child: Icon(Icons.add),
      ),
    );
  }
}
