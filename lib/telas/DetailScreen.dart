import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:e_carto/Parcial/Carousel.dart';
import 'package:e_carto/Parcial/MateriaisList.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';

import '../main.dart';

import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  @override
  Details createState() => new Details();
}

class Details extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // var todo = ModalRoute.of(context).settings.arguments;
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;
    String formatDate(DateTime date) =>
        new DateFormat("MMMM d").format(item.updated_at);
    String update = DateFormat('dd/MM/y kk:mm').format(item.updated_at);

    @override
    void initState() {
      super.initState();
      print(item);
    }

    var thumb;
    var passoAPasso;
    thumb = Image.asset('assets/logo.png');

    if (item.thumbnail != null) {
      thumb = Image.network(host + item.thumbnail);
    }

    if (item.steps.length != 0) {
      passoAPasso = RaisedButton(
        padding: EdgeInsets.all(20),
        onPressed: () {
          showFancyCustomDialog(context);
        },
        color: Colors.white,
        child: Text("Passo a passo"),
      );
    } else {
      passoAPasso = RaisedButton(
          padding: EdgeInsets.all(20),
          onPressed: () {
            // showFancyCustomDialog(context);
          },
          color: Colors.white70,
          child: Text("Passo a passo indisponível",
              style: TextStyle(color: Colors.white)));
    }

    // print(item.steps[0]);

    // Use the item to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),  
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: new ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: thumb),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(item.description), //
            ),
            MateriaisList(),
            passoAPasso,
            Container(
              alignment: Alignment(1.0, 1.0),
              padding: EdgeInsets.fromLTRB(5, 45, 5, 5),
              child: Text("Última atualização em: " + update), //
            )
          ])),
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;

    Dialog fancyDialog = Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: CarouselList(item.steps),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Fechar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(0.9, -0.9),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }
}

//  NetworkImage(host + item.thumbnail)
