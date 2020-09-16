import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

_modalContatoAutor(autor){

    double dividerHeigth = 20;
    var dividerColor = Colors.black45;
    
    var textColor;
    Get.dialog(Card(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
          child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  autor['name'] != ""
                      ? ListTile(
                          title: Text(autor['name'],
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                        )
                      : ListTile(
                          title: Text(autor['username'],
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                        ),
                  Divider(
                    // height: dividerHeigth,
                    color: dividerColor,
                    thickness: 3,
                  ),
                  autor['phone'] != ""
                      ? ListTile(
                          onTap: () => launch(
                              "https://wa.me/55${autor['phone']}?text=Olá%20te%20Encontrei%20no%20Ecarto%20"),
                          title: Text('Telefone: ' + autor['phone']),
                        )
                      : Container(),
                  Divider(),
                  autor['email'] != ""
                      ? ListTile(
                          onTap: () => launch(
                              "mailto:${autor['email']}?subject=Contato do app Ecarto"),
                          title: Text('Email: ' + autor['email']),
                        )
                      : Container(),
                  Divider(),
                  // Divider(height: dividerHeigth),
                  autor['instagram'] != ""
                      ? ListTile(
                          onTap: () => launch(
                              "https://instagram.com/${autor['instagram']}"),
                          title: Text('Instagram: ' + autor['instagram']),
                        )
                      : Container(),
                  Divider(),
                  // Divider(height: dividerHeigth),
                  
                  // Center(
                  //     child: Container(
                  //         child: ListTile(
                  //   onLongPress:
                  //     () => Navigator.pop(context)
                  //   ,
                  //   title: Text('Fechar'),
                  // )))
                ],
              ))));
  
}