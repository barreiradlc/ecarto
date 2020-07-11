import 'dart:convert';
import 'dart:io';
import 'dart:wasm';

import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Construtores/StepsConstructor.dart';
import 'package:ecarto/Funcoes/Fetch.dart';

import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/telas/Camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../Recursos/Api.dart';

class FormItemPage extends StatefulWidget {
  @override
  _FormItemPageState createState() => _FormItemPageState();
}

class _FormItemPageState extends State<FormItemPage> {
  var item;
  bool edit;
  bool isSwitched;
  bool loading = true;
  var label = 'novo';
  var labelArte = 'Nova Arte';
  var labelMaterial = 'Novo Material';
  var position;

  File _image;

  var nome = TextEditingController(text: '');
  var preco = TextEditingController(text: '0');
  var descricao = TextEditingController(text: '');

  String jwt;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    print('image');
    print(image);
    print('image');

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

  Future<String> removeImage() async {
    setState(() {
      _image = null;
    });
  }

  Future req() async {
    if (nome.text == '') {
      return Get.snackbar("Erro", "Nome do Item é obrigatório!",
          snackPosition: SnackPosition.BOTTOM);
    }

    Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);

    Dio dio = new Dio();
    var response;
    var endpoint = '/items';

    print(position);

    FormData formData = FormData.fromMap({
      'title': nome.text,
      'description': descricao.text,
      'nature': isSwitched == true ? 'ARTE' : 'MATERIAL',
      'price': double.parse(preco.text),
      'latitude': position.latitude,
      'longitude': position.longitude
      // 'avatar': await MultipartFile.fromFile(_image,   )
      // 'avatar': await MultipartFile.fromFile(_image.path,
      //     filename: nome.text + ".png"),
    });

    if (_image != null) {
      formData.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(_image.path,
              filename: nome.text + ".png")));
    }

    print(formData.fields);

    if (!edit) {
      response = await dio.post(
        host + endpoint,
        data: formData,
        options: Options(headers: {
          "Authorization": this.jwt,
          "Content-Type": "multipart/form-data"
        }),
      );
    } else {
      print('################');
      print('PUT');
      print('################');

      response = await dio.put(
        host + endpoint + '/${item.id.toString()}',
        data: formData,
        options: Options(headers: {
          "Authorization": this.jwt,
          "Content-Type": "multipart/form-data"
        }),
      );
    }
    print('formData');
    print(response.data);
    print(response);
    print('re sponse');
    print('response');
    var res = response.data;
    // var id = int.parse(res['id']);

    // print(id);

    Navigator.pop(context);

    if (res['id'] != null) {
      Get.snackbar("Sucesso", "${nome.text} registrado(a) com sucesso!",
          snackPosition: SnackPosition.BOTTOM);
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

  getLocation() async {
    var p = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    print('p');
    print(p);
    print(p.latitude);

    setState(() {
      position = p;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    print('position');
    print(position);
    void_getJWT().then((jwt) {
      setState(() {
        this.jwt = jwt;
      });

      // this.getData();
    });
  }

  Widget build(BuildContext context) {
    edit = true;

    item = ModalRoute.of(context).settings.arguments;

    print('isSwitched');
    print(isSwitched);

    if (item is String) {
      // setState(() {
      // });

      if (isSwitched == null) {
        setState(() {
          isSwitched = item == "arte" ? true : false;
        });
      }
      setState(() {
        edit = false;
      });
    }

    if (loading) {
      if (!edit) {
        // if(isSwitched != null){
        // }
        print('create');
      } else {
        print(item.nature == "ARTE");
        print('item.nature');
        print(item);

        setState(() {
          labelArte = 'Editar Arte';
          labelMaterial = 'Editar Material';
          isSwitched = item.nature == 'ARTE' ? true : false;
          nome.text = item.title;
          descricao.text = item.description;
          preco.text = item.price.toString();
          // _image = item.thumbnail != '' || null) ? File(host + item.thumbnail) : null;
        });
        // preco
        // descricao
        print('edit');
      }
      print('item');
      print(isSwitched);
      print('item');
    }

    if (loading) {
      setState(() {
        // isSwitched = item == "ARTE" ? true : false;
        loading = false;
      });
    }
    // print(item);

    return Theme(
        data: new ThemeData(
          primaryColor: isSwitched
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          // primaryColorDark: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: Text(isSwitched ? labelArte : labelMaterial,
                  style: TextStyle(color: Colors.white)),
              backgroundColor: isSwitched
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
            ),

            // primary: : isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
            // backgroundColor: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
            body: AnimatedContainer(
                duration: Duration(seconds: 3),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 40, top: 30),
                      child: Form(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: <
                                  Widget>[
                        // IMG DESCOMENTAR

                        // _image == null
                        //     ? Container(
                        //         margin: EdgeInsets.symmetric(vertical: 10),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //           children: <Widget>[
                        //             FlatButton(
                        //                 padding: EdgeInsets.symmetric(
                        //                     vertical: 10, horizontal: 0),
                        //                 onPressed: getImage,
                        //                 child: Container(
                        //                     width:
                        //                         (MediaQuery.of(context).size.width /
                        //                                 2) -
                        //                             20,
                        //                     height: 200,
                        //                     alignment: Alignment.center,
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.center,
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: <Widget>[
                        //                         Row(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.center,
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.center,
                        //                           children: <Widget>[
                        //                             Icon(
                        //                               Icons.add_a_photo,
                        //                               size: 22,
                        //                             ),
                        //                             Text(
                        //                               'Camera',
                        //                               style:
                        //                                   TextStyle(fontSize: 15),
                        //                             )
                        //                           ],
                        //                         )
                        //                       ],
                        //                     ))),
                        //             FlatButton(
                        //                 padding: EdgeInsets.symmetric(vertical: 10),
                        //                 onPressed: getImageGal,
                        //                 child: Container(
                        //                     height: 200,
                        //                     width:
                        //                         (MediaQuery.of(context).size.width /
                        //                                 2) -
                        //                             20,
                        //                     alignment: Alignment.center,
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.center,
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: <Widget>[
                        //                         Row(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.center,
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.center,
                        //                           children: <Widget>[
                        //                             Icon(
                        //                               Icons.add_photo_alternate,
                        //                               size: 22,
                        //                             ),
                        //                             Text(
                        //                               'Galeria',
                        //                               style:
                        //                                   TextStyle(fontSize: 15),
                        //                             )
                        //                           ],
                        //                         )
                        //                       ],
                        //                     )))
                        //           ],
                        //         ))
                        //     : Stack(children: <Widget>[
                        //         Container(
                        //           padding: EdgeInsets.symmetric(vertical: 20),
                        //           child: !edit
                        //               ? Image.network(
                        //                   _image.path,

                        //                   width: MediaQuery.of(context).size.width,
                        //                   fit: BoxFit.cover,
                        //                 )
                        //               : Image.file(
                        //                   _image,
                        //                   width: MediaQuery.of(context).size.width,
                        //                   height: 200,
                        //                   fit: BoxFit.cover,
                        //                 ),
                        //         ),
                        //         Positioned(
                        //             top: 30.0,
                        //             right: -10,
                        //             child: FlatButton(
                        //               onPressed: removeImage,
                        //               child: Icon(Icons.close, size: 30, ),
                        //             )),
                        //       ]),

                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              // cursorColor: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                              cursorColor: isSwitched
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
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
                                // fillColor: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                                filled: true,
                                focusColor: isSwitched
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).accentColor,
                                // hoverColor: isSwitched ? Theme.of(context).primaryColor : Them e.of(context).accentColor,
                                // hoverColor: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,

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
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Material",
                                    style: TextStyle(
                                        color: isSwitched
                                            ? Colors.black38
                                            : Theme.of(context).accentColor)),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    print('val');
                                    print(value);
                                    print(isSwitched);
                                    print('val');

                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                  activeTrackColor: Colors.lightBlue,
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveTrackColor: Colors.lightGreenAccent,
                                  inactiveThumbColor:
                                      Theme.of(context).accentColor,
                                ),
                                Text(
                                  "Arte",
                                  style: TextStyle(
                                      color: isSwitched
                                          ? Theme.of(context).primaryColor
                                          : Colors.black38),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              // cursorColor: isSwitched ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                              cursorColor: isSwitched
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                              controller: preco,

                              // obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                            color: isSwitched
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                            padding: EdgeInsets.all(15),
                            onPressed: req,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Text(isSwitched ? labelArte : labelMaterial,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ))
                      ])),
                    ),
                  ],
                ))));
  }
}

class UploadFileInfo {}
