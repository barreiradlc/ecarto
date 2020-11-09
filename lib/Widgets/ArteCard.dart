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

  // _tween<Rect>({Rect: a, Rect: b}) {

  // }

  @override
  Widget build(BuildContext context) {
    var arte = widget.arte;

    var bg;
    var fit = BoxFit.cover;
    var alignment = Alignment.topCenter;
    var placeholder = Image.asset("assets/logo.png",fit: fit, alignment: alignment);
    var thumbnail = Image.network(arte['image'],fit: fit, alignment: alignment, width: 350, height: 350, colorBlendMode: BlendMode.srcOver, color: Colors.black45);

    if (arte['image'] != null) {
      if (arte['image'] == null) {
        bg = placeholder;
        // bg = AssetImage("assets/logo.png");
      } else {
        bg = thumbnail;
        // bg = NetworkImage(arte['image']);
      }
    } else {
      bg = placeholder;
      // bg = AssetImage("assets/logo.png");
    }

    // ITEM

    return Container( 
      decoration: BoxDecoration(          
          borderRadius: BorderRadius.all(Radius.circular(5)),          

      ),
      
      margin: EdgeInsets.only(right: 25),
      child: Stack(      
        overflow: Overflow.clip,
      children: [
        ClipPath(          
          child: 
            Hero(
              tag: 'Thumbnail${arte['_id']}', child: bg),        
        ),
        FlatButton(
            padding: EdgeInsets.all(0),
            color: Colors.white12,
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
                  arte['_id'],
                ),
              );
              print('pokebola vai');
            },
            child: Container(
                padding: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     // scale: 0.25,
                //     // image: bg,
                //     fit: BoxFit.cover,
                //     colorFilter: new ColorFilter.mode(
                //         Colors.white.withOpacity(0.3), BlendMode.srcOver),
                //   ),
                // ),
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
                            
                            Expanded(
                              child: Text(
                                widget.arte['title'],
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 15),
                              child:
                              Hero(
                                // createRectTween: _tween,                                
                                tag: 'Price${arte['_id']}', child:         
                              Text(
                                'R\$ ${widget.arte['price'].toString()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                      // Text(widget.arte['description'])
                    ],
                  ),
                )))
      ],
    )
    );

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
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 15),
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
