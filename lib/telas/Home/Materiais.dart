import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Recursos/Api.dart';
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
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: GridView.count(
          padding: EdgeInsets.only(top: 25),
          // crossAxisCount is the number of columns
          crossAxisCount: 2,
          // This creates two columns with two items in each column
          children: List.generate(
            widget.materiais.length,
            (index) {
              var bg;

              // if (widget.materiais[index]['avatar']['url'] == null) {
              //   bg = AssetImage("assets/logo.png");
              // } else {
              //   bg = NetworkImage(
              //       host + widget.materiais[index]['avatar']['url']);
              // }
              
              bg = AssetImage("assets/logo.png");

              return new Container(
                  margin: EdgeInsets.all(5),
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
                            DateTime.parse(
                            widget.materiais[index]['updated_at']),
                            widget.materiais[index]['nature'],
                            widget.materiais[index]['user_id'],
                            widget.materiais[index]['id'],
                            widget.materiais[index]['price'],
                          ),
                        );
                        // print('pokebola vai');
                      },
                      child: Container(
                        // foregroundDecoration: BoxDecoration(
                        //   color: Colors.grey,
                        //   backgroundBlendMode: BlendMode.saturation,
                        // ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: bg,
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.lightGreen.withOpacity(0.6),
                                  BlendMode.srcOver),
                            ),
                          ),
                          child: new Container(
                            padding: EdgeInsets.all(5),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                        padding: const EdgeInsets.all(2),
                                      ),
                                      Container(
                                        child: Text(
                                          'R\$ ${widget.materiais[index]['price'].toString()}',
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
          )),
      // floatingActionButton: FloatingActionButton(
      //   // When the user presses the button, show an alert dialog containing
      //   // the text that the user has entered into the text field.
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/itens/form', arguments: "material");
      //   },
      //   tooltip: 'Criar Material',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
