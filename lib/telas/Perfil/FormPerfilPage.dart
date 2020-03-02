import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:e_carto/Construtores/StepsConstructor.dart';
import 'package:e_carto/Construtores/UserArguments.dart';

import 'package:e_carto/Funcoes/UserData.dart';
import 'package:e_carto/telas/Camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../Recursos/Api.dart';

class FormPerfilPage extends StatefulWidget {
  @override
  FormPerfilPageState createState() => FormPerfilPageState();
}

class FormPerfilPageState extends State<FormPerfilPage> {
  bool isSwitched = true;
  bool loading = true;
  var label = 'novo';
  var labelArte = 'Nova Arte';
  var labelMaterial = 'Novo Material';

  File _image;
  var preco = TextEditingController(text: '0');

  // var nome = TextEditingController(text: '');
  // var email = TextEditingController(text: '');
  // var descricao = TextEditingController(text: '');

  var id = TextEditingController(text: '');
  var name = TextEditingController(text: '');
  var nome = TextEditingController(text: '');
  var username = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var phone = TextEditingController(text: '');
  var instagram = TextEditingController(text: '');
  var pinterest = TextEditingController(text: '');
  var about = TextEditingController(text: '');
  var avatar = TextEditingController(text: '');

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

  Future<String> reqEdit() async {}

  Future<String> req() async {
    Dio dio = new Dio();
    var response;
    var endpoint = '/items';

    // print(jwt);

    FormData formData = FormData.fromMap({
      'title': nome.text,
      'description': about.text,
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

  Widget build(BuildContext context) {
    final UserArguments item = ModalRoute.of(context).settings.arguments;

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

    bool edit;

    if (item is String) {
      print('create');
    } else {
      print('edit');
    }
    print('item');
    print(item.avatar['url']);
    print('item');

    if (loading) {
      setState(() {
        id.text = item.id.toString();
        name.text = item.name;
        username.text = item.username;
        email.text = item.email;
        phone.text = item.phone;
        instagram.text = item.instagram;
        pinterest.text = item.pinterest;
        about.text = item.about;
        avatar.text = item.avatar['url'];
        loading = false;
      });
    }
    // print(item);

    return Theme(
        data: new ThemeData(
          primaryColor: isSwitched ? Colors.green : Colors.blue,
          // primaryColorDark: isSwitched ? Colors.green : Colors.blue,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Editar Perfil'),
              backgroundColor: Colors.blue,
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

                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('Dados pessoais'),
                    )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: username,

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Login',
                          ),
                          // autofocus: true,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: name,

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Nome',
                          ),
                          // autofocus: true,
                        )),
                    
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 3,
                          controller: about,
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
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('Dados de contato'),
                    )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: email,

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Email',
                          ),
                          // autofocus: true,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: phone,

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Telefone',
                          ),
                          // autofocus: true,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: phone,

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Instagram',
                          ),
                          // autofocus: true,
                        )),
                    // alignment: Alignment(1.0, 1.0),
                    RaisedButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: req,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text('Editar Perfil',
                                  style: TextStyle(color: Colors.white))
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
