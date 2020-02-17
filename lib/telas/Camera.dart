import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;


class Camera extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Camera> {
  File _image;

  

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future<String> req() async {
    var url = 'https://ae-teste.herokuapp.com';
    var endpoint = '/wikis';

    http.Response response =
        await http.post(Uri.encodeFull(url + endpoint), body: {
      // 'username': usuarioCred.text,
      // 'email': myController.t ext,
      'avatar': _image
    });

    print(response.body);
  }

  Future<String> teste() async {
    print(_image);
  }


  Future getImageGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    onPressed: getImage,
                    child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.add_a_photo,
                                  size: 22,
                                ),
                                Text(
                                  'Camera',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ))),
                FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: getImageGal,
                    child: Container(
                        height: 200,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 22,
                                ),
                                Text(
                                  'Galeria',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            )
                          ],
                        )))
              ],
            ))
        : Image.file(
            _image,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          );
  }
}
