import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';

class Passo extends StatefulWidget {
  final i;
  var estado;
  Passo(this.i, estado);

  @override
  _PassoState createState() => _PassoState();
}

class _PassoState extends State<Passo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var bg;
    bg = AssetImage("assets/logo.png");
    if (widget.estado == 'editar') {
      if (widget.i['avatar']['url'] != null) {
        bg = NetworkImage(host + widget.i['avatar']['url']);
      }
    }

    print(widget.estado);

    if (widget.estado == 'editar') {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bg,
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Text(
                    // 'text $i',
                    widget.i['title'],
                    style: TextStyle(fontSize: 16.0),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Text(
                    // 'text $i',
                    widget.i['description'],
                    style: TextStyle(fontSize: 16.0),
                  ))
            ]));
  } else {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            Text('Novo Passo')
          ],
        )),
    );
  }
}
}
