import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:ecarto/Widgets/Distancia.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  var position;

getLocation() async {
    var p = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('position');
    print(p);
    print(p.latitude);

    setState(() {
      position = p;
    });

    return p;
  }

  @override
  void initState() {
    super.initState();
      getLocation();
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

              if (widget.materiais[index]['image'] != null) {                
                if (widget.materiais[index]['image'] == null) {
                  bg = AssetImage("assets/logo.png");
                } else {
                  bg = NetworkImage(widget.materiais[index]['image']);
                }
              } else {
                bg = AssetImage("assets/logo.png");
              }                                          
              
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
                            widget.materiais[index]['image'],
                            DateTime.parse(
                              widget.materiais[index]['updated_at']
                            ),
                            widget.materiais[index]['nature'],
                            widget.materiais[index]['user']['_id'],
                            widget.materiais[index]['_id'],
                            widget.materiais[index]['price'],
                            index,
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
                                  Colors.white.withOpacity(0.3),
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
                                              color: Theme.of(context).accentColor),
                                        ),
                                        padding: const EdgeInsets.all(2),
                                      ),
                                       Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: 
                                                Distancia(widget.materiais[index], position),
                                              padding: const EdgeInsets.only(left: 20, bottom:5),
                                            ),
                                            
                                            Container(
                                              child: Text(
                                                'R\$ ${widget.materiais[index]['price'].toString()}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).accentColor
                                                  ),
                                              ),
                                              padding: const EdgeInsets.only(left: 20, bottom:15),
                                            ),

                                          ],
                                        )
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
      //   backgroundColor: Theme.of(context).accentColor,
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/itens/form', arguments: "material");
      //   },
      //   tooltip: 'Criar Material',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
