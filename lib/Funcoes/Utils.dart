import 'package:flutter/material.dart';

dialogoAlerta(String msg, context,{ bool loading = true}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      msg,
                    )
                  ],
                )));
      },
    );
  }
  
  // multiplas mensagens
  dialogoAlertaLista(List<String> msgs, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: 
                  Column(children: msgs.map((item) => new Text(item)).toList())
                 ));
      },
    );
  }