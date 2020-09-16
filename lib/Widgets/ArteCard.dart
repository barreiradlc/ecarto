import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:flutter/material.dart';

import 'Distancia.dart';

class ArteCard extends StatefulWidget {
  final arte;

  ArteCard(this.arte);

  @override
  _ArteCardState createState() => _ArteCardState();
}

class _ArteCardState extends State<ArteCard> {
  @override
  Widget build(BuildContext context) {
    var arte = widget.arte;

    var bg;

    if (arte['image'] != null) {
      if (arte['image'] == null) {
        bg = AssetImage("assets/logo.png");
      } else {
        bg = NetworkImage(arte['image']);
      }
    } else {
      bg = AssetImage("assets/logo.png");
    }

    // ITEM
    
    return new Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0))),
        padding: EdgeInsets.only(right: 15),
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/item',
                arguments: ScreenArguments(
                  arte['title'],
                  arte['description'],
                  arte['image'],
                  DateTime.parse(arte['updated_at']),
                  arte['nature'],
                  arte['user'],
                  arte['_id'],
                  arte['price'],
                  null,
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
                        Colors.white.withOpacity(0.3), BlendMode.srcOver),
                  ),
                ),
                child: new Container(
                  padding: EdgeInsets.all(5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                Text(
                                widget.arte['title'],
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                            ),
                            ),
                            Container(
                                  padding: const EdgeInsets.only( left: 20, bottom: 15),
                                  child: Text(
                                    'R\$ ${widget.arte['price'].toString()}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                  ),
                                ),
                                )
                              
                            
                          ],
                        ),
                      )
                      // Text(widget.arte['description'])
                    ],
                  ),
                ))));
    // return Container(
    //    child: Text('${arte['title']}'),
    // );
  }
}
