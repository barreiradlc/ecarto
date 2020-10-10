import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:ecarto/Widgets/Distancia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

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
  var position;

  getLocation() async {
    var p = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      position = p;
    });

    return p;
  }

  getDistancia(arte) async {
    print('arte');
    print(arte['latitude']);
    print(arte['longitude']);

    print(position.latitude);
    print(position.longitude);

    var startLat = double.parse(arte['latitude']);
    var startLong = double.parse(arte['longitude']);

    var endLat = position.latitude;
    var endLong = position.longitude;

    double distanceInMeters = await distanceBetween(startLat, startLong, endLat, endLong);
    return distanceInMeters.toInt();
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
    // final title = 'Grid List';

    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    print(widget.artes);

    return Scaffold(

        // appBar: AppBar(
        //   title: Text(title),
        // ),

        // <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        // <ins class="adsbygoogle"
        //      style="display:block"
        //      data-ad-format="fluid"
        //      data-ad-layout-key="-fb+5w+4e-db+86"
        //      data-ad-client="ca-pub-5489812063406279"
        //      data-ad-slot="9775639514"></ins>
        // <script>
        //      (adsbygoogle = window.adsbygoogle || []).push({});
        // </script>

        body: GridView.count(
            padding: EdgeInsets.only(top: 25),
            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            

            // This creates two columns with two items in each column
            children: List.generate(widget.artes.length, (index) {
              var bg;
              var distancia = '';
              var load = true;


              if (widget.artes[index]['image'] != null) {                
                if (widget.artes[index]['image'] == null) {
                  bg = AssetImage("assets/logo.png");
                } else {
                  bg = NetworkImage(widget.artes[index]['image']);
                }
              } else {
                bg = AssetImage("assets/logo.png");
              }                                          

              // if(load){
              //   return Container(
              //     child: Center(child: 
              //       LinearProgressIndicator()
              //     ,),
              //   );
              // }

              if (widget.artes[index]['nature'] == 'ARTE') {

                return new Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0)                        
                      )
                    ),
                    margin: EdgeInsets.all(5),
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
                              widget.artes[index]['image'],
                              DateTime.parse(widget.artes[index]['updated_at']),
                              widget.artes[index]['nature'],
                              widget.artes[index]['user']['_id'],
                              widget.artes[index]['_id'],
                              widget.artes[index]['price'],
                              index,
                            ),
                          );
                          print('pokebola vai');
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                // scale: 0.25,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            widget.artes[index]['title'],
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
                                                Distancia(widget.artes[index], position),
                                              padding: const EdgeInsets.only(left: 20, bottom:5),
                                            ),
                                            Container(
                                              child: Text(
                                                'R\$ ${widget.artes[index]['price'].toString()}',
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
                                  // Text(widget.artes[index]['description'])
                                ],
                              ),
                            )))
                            );
              } else {
                print('alou');
                
              }
            }))

        // floatingActionButton: FloatingActionButton(
        //   // When the user presses the button, show an alert dialog containing
        //   // the text that the user has entered into the text field.
        //   foregroundColor: Colors.white,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/itens/form', arguments: "arte");
        //   },
        //   tooltip: 'Criar Arte',
        //   child: Icon(Icons.add),
        // ),
        );
  }
}
