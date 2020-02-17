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

import '../../Recursos/Api.dart';

class FormItemPage extends StatefulWidget {
  @override
  _FormItemPageState createState() => _FormItemPageState();
}

class _FormItemPageState extends State<FormItemPage> {

  bool isSwitched = true;

  var label = 'novo';
  var labelArte = 'Nova Arte';
  var labelMaterial = 'Novo Material';

  File _image;

  var nome = TextEditingController(text: '');
  var preco = TextEditingController(text: '0');
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
    var endpoint = '/items';

    // print(jwt);

    FormData formData = FormData.fromMap({
      'title': nome.text,
      'description': descricao.text,
      'nature': isSwitched == true ? 'ARTE' : 'MATERIAL',
      'price': int.parse(preco.text),
      // 'avatar': await MultipartFile.fromFile(_image,   )
      'avatar': await MultipartFile.fromFile(_image.path,
          filename: nome.text + ".png"),
    });

    // print(formData);


    response = await dio.post(
      host + endpoint,
      data: formData,
      options: Options(headers: {
        "Authorization": this.jwt,
        "Content-Type": "multipart/form-data"
      }),
    );
    print('formData');
    print(response.data);
    print(response);
    print('re sponse');
    print('response');
    var res = response.data;
    // var id = int.parse(res['id']);

    // print(id);

    if (res['id'] != null) {
      await Navigator.pushNamed(context, '/home');
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
    final item = ModalRoute.of(context).settings.arguments;
    print(item);
      setState(() {
        isSwitched = item == "arte" ? true : false;
      });

    return Theme(
        data: new ThemeData(
          primaryColor: isSwitched ? Colors.green : Colors.blue,
          // primaryColorDark: isSwitched ? Colors.green : Colors.blue,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: Text(isSwitched ? labelArte : labelMaterial),
              backgroundColor: isSwitched ? Colors.green : Colors.blue,
            ),

            // primary: : isSwitched ? Colors.green : Colors.blue,
            // backgroundColor: isSwitched ? Colors.green : Colors.blue,
            body: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Form(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                    Text(
                      "Foto",
                      style: TextStyle(fontSize: 23),
                    ),
                    _image == null
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    onPressed: getImage,
                                    child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        height: 200,
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.add_a_photo,
                                                  size: 22,
                                                ),
                                                Text(
                                                  'Camera',
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.add_photo_alternate,
                                                  size: 22,
                                                ),
                                                Text(
                                                  'Galeria',
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
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
                            // fillColor: isSwitched ? Colors.green : Colors.blue,
                            filled: true,
                            focusColor: isSwitched ? Colors.green : Colors.blue,
                            // hoverColor: isSwitched ? Colors.green : Colors.blue,
                            // hoverColor: isSwitched ? Colors.green : Colors.blue,

                            // disabledBorder: InputBorder.none ,
                            fillColor: Colors.white,
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
                    // Container(
                    //     padding: EdgeInsets.symmetric(vertical: 20),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: <Widget>[
                    //         Text("Material",
                    //             style: TextStyle(
                    //                 color: isSwitched
                    //                     ? Colors.black38
                    //                     : Colors.blue)),
                    //         Switch(
                    //           value: isSwitched,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               isSwitched = value;
                    //             });
                    //           },
                    //           activeTrackColor: Colors.lightGreenAccent,
                    //           activeColor: Colors.green,
                    //           inactiveTrackColor: Colors.lightBlueAccent,
                    //           inactiveThumbColor: Colors.blue,
                    //         ),
                    //         Text(
                    //           "Arte",
                    //           style: TextStyle(
                    //               color: isSwitched
                    //                   ? Colors.green
                    //                   : Colors.black38),
                    //         ),
                    //       ],
                    //     )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: preco,

                          // obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Preço',
                            prefixText: 'R\$: ',
                          ),
                          // keyboardAppearance: ,
                          keyboardType: TextInputType.number,

                          autofocus: false,
                        )),
                    // Text("Adicionar imagem:"),

                    // alignment: Alignment(1.0, 1.0),
                    RaisedButton(
                        color: isSwitched ? Colors.green : Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: req,
                        child: Center(

                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text(isSwitched ? labelArte : labelMaterial, style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ))
                  ])),
                ),
              ],
            )));
  }
}

class UploadFileInfo {}
