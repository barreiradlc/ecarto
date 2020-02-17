import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:e_carto/Construtores/StepsConstructor.dart';

import 'package:e_carto/Funcoes/UserData.dart';
import 'package:e_carto/telas/Camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../db_test.dart' as db;

class FormWikiPage extends StatefulWidget {
  @override
  _FormWikiPageState createState() => _FormWikiPageState();
}

class _FormWikiPageState extends State<FormWikiPage> {
  var label = 'novo';
  File _image;

  var nome = TextEditingController(text: '');
  var descricao = TextEditingController(text: '');

  String jwt;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<String> req() async {
    Dio dio = new Dio();
    var response;
    var url = 'https://ae-teste.herokuapp.com';
    var endpoint = '/wikis';

    FormData formData = FormData.fromMap({
      'title': nome.text,
      'description': descricao.text,
      // 'avatar': await MultipartFile.fromFile(_image,   )
      "avatar": await MultipartFile.fromFile(_image.path,
          filename: nome.text + ".png"),
    });

    response = await dio.post(
      url + endpoint,
      data: formData,
      options: Options(headers: {
        "Authorization": this.jwt,
        "Content-Type": "multipart/form-data"
      }),
    );

    print(formData);
    print('formData');

    print('re sponse');
    print(response);
    print('response');
    var res = response.data;
    // var id = int.parse(res['id']);


    // print(id);

    if(res['id'] != null){
      await Navigator.pushNamed(
        context,
        '/steps/form',
        arguments: StepsArguments(
          res['id'],
          res['title'],
          res['steps']
        )
      );
    }





    // http.Response response = await http.post(Uri.encodeFull(url + endpoint),
    //     body: {
    //       'title': nome.text,
    //       'description': descricao.text,
    //       'avatar': _image
    //     });

    // print(response.body);
  }

  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      setState(() {
        this.jwt = jwt;
      });
      // this.getData();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo tutorial")),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(

            // backgroundColor: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: nome,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  labelText: 'Nome',
                ),
                autofocus: true,
              )),
          Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                controller: descricao,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  alignLabelWithHint: true,
                  labelText: 'Descrição',
                ),
                // autofocus: true,
              )),

          // Text("Adicionar imagem:"),
          _image == null
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          onPressed: getImage,
                          child: Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              height: 200,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                ),
          // alignment: Alignment(1.0, 1.0),
          RaisedButton(
              color: Colors.green,
              padding: EdgeInsets.all(5),
              onPressed: req,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    Text(label, style: TextStyle(color: Colors.white))
                  ],
                ),
              ))
        ])),
      ),
    );
  }
}

class UploadFileInfo {}
