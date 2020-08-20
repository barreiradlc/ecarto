import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecarto/Construtores/UserArguments.dart';
import 'package:ecarto/Funcoes/Fetch.dart';

import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Funcoes/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Recursos/Api.dart';

class FormPerfilPage extends StatefulWidget {
  @override
  FormPerfilPageState createState() => FormPerfilPageState();
}

class FormPerfilPageState extends State<FormPerfilPage> {

  bool edit = false;
  bool changeImage = false;
  bool isSwitched = true;
  bool loading = true;
  var label = 'novo';
  var labelArte = 'Nova Arte';
  var labelMaterial = 'Novo Material';

  File _image;
  String image;
  var preco = TextEditingController(text: '0');

  // var nome = TextEditingController(text: '');
  // var email = TextEditingController(text: '');
  // var descricao = TextEditingController(text: '');
  var dropdownValue;
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

  removeImage() async {
    setState(() {
      _image = null;
      changeImage = true;
    });
  }

  Future getImage() async {
    var getImage = await ImagePicker.pickImage(source: ImageSource.camera);    
    getImage = await compressImage(getImage);

    setState(() {
      _image = getImage;      
      changeImage = true;
    });
  }

  Future getImageGal() async {
      var getImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      getImage = await compressImage(getImage);

      setState(() {
        _image = getImage;
        changeImage = true;        
      });
  }
    
      Future<String> reqEdit() async {}
    
      uploadImage() async {

        if(!changeImage){
          return _image.path;
        }

        Dio dio = new Dio();
    
        print(dio);
    
        FormData formData = FormData.fromMap({});
    
        print(formData);
    
        formData.files.add(
          MapEntry(
              'file', 
              await MultipartFile.fromFile(_image.path)
          )
        );
        
        var response = await dio.post(
            '$hostImg/upload?d=$image',
            data: formData,
            options: Options(headers: {
              "Content-Type": "multipart/form-data"
            }),
        );
    
        print('UPLOAD');
        print(response);
        print(response.data);
        print('UPLOAD');
    
        return response.data['img'];
      }
    
      Future<String> req() async {
        Get.dialog(alertWidget(),
            barrierDismissible: false, useRootNavigator: false);
    
        Dio dio = new Dio();
        var response;
        var endpoint = '/users/${id.text.toString()}';
    
        print(jwt);
        print(endpoint);
    
        FormData formData = FormData.fromMap({
          'name': name.text,
          // 'username': username.text,
          'email': email.text,
          'phone': phone.text,
          'instagram': instagram.text,
          'image': _image != null ? await uploadImage() : '',
          // 'pinterest': pinterest.text,
          'about': about.text,
    
          // 'title': nome.text,
          // 'description': about.text,
          // 'nature': isSwitched == true ? 'ARTE' : 'MATERIAL',
          // 'price': int.parse(preco.text),
          // 'avatar': await MultipartFile.fromFile(_image,   )
    
          // 'avatar': await MultipartFile.fromFile(_image.path,
          //     filename: nome.text + ".png"),
        });
    
        print(formData.fields);
    
        response = await dio.put(
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

        Navigator.pop(context);
    
        if (res['id'] != null) {
          // await Navigator.pop(context);

          await Navigator.pushReplacementNamed(context, '/perfil');
          
          // Future.delayed(const Duration(milliseconds: 1000), () {
          //   Navigator.pop(context, '/perfil');
          // });
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
    
      getImageService(item){    
        
        print("Img");
        print('$hostImg/uploads/${item.avatar}');
        print("Img");
    
        if(item.avatar == '' || item.avatar == null){
          print('SEM IMAGEM');
          return;
        }   
        setState(() {
            _image = File(item.avatar);
            image = item.avatar;
        });
        
      }
    
      Widget build(BuildContext context) {
        final UserArguments item = ModalRoute.of(context).settings.arguments;
    
    
        if (item is String) {
          print('create');
        } else {
          print('edit');
        }
        print('item');
        print(item.avatar);
        print('$hostImg/uploads/${item.avatar}');
        print('item');
        
        if(!changeImage){
          getImageService(item);
        }
    
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
            // _image = item.avatar != '' || null ? File('$hostImg/uploads/${item.avatar}') : null;
            loading = false;
          });
        }
    
        print(item);    
    
        return Theme(
            data: new ThemeData(
              primaryColor: Theme.of(context).accentColor,
              // primaryColorDark: Theme.of(context).accentColor,
            ),
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Editar Perfil'),
                  backgroundColor: Theme.of(context).accentColor,
                ),
    
                // primary: : Theme.of(context).accentColor,
                // backgroundColor: Theme.of(context).accentColor,
                body: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Form(
                          child: Column(mainAxisSize: MainAxisSize.min, children: <
                              Widget>[
                        
                        // IMG
                        
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
                            : Stack(children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      child: !changeImage
                                          ? Image.network(
                                              _image.path,
                                              width: MediaQuery.of(context).size.width,
                                              height: 240,
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Image.file(
                                              _image,
                                              width: MediaQuery.of(context).size.width,
                                              height: 240,
                                              fit: BoxFit.fitWidth,                                          
                                            ),
                                    ),
                                    Positioned(
                                        top: 30.0,
                                        right: 10,
                                        width: 60,
                                        height:60,
                                        child: FlatButton(
                                        padding: EdgeInsets.all(5),
                                          color: Colors.white30,
                                          onPressed: removeImage,
                                          child: Icon(Icons.close, size: 30, ),
                                        )),
                                  ]),
    
    
                        // IMG
    
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text('Dados pessoais'),
                        )),
    
                        // formTextInput('Login', username, null, null),
                        formTextInput('Nome ', name, null, null),
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 10),
                        //     child: TextField(
                        //       // cursorColor: Theme.of(context).accentColor,
                        //       cursorColor: Theme.of(context).accentColor,
                        //       controller: username,
    
                        //       // obscureText: true,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(5.0),
                        //           ),
                        //         ),
                        //         labelText: 'Login',
                        //       ),
                        //       // autofocus: true,
                        //     )),
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 10),
                        //     child: TextField(
                        //       // cursorColor: Theme.of(context).accentColor,
                        //       cursorColor: Theme.of(context).accentColor,
                        //       controller: name,
    
                        //       // obscureText: true,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(5.0),
                        //           ),
                        //         ),
                        //         labelText: 'Nome',
                        //       ),
                        //       // autofocus: true,
                        //     )),
    
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 10),
                        //     child: TextField(
                        //       keyboardType: TextInputType.multiline,
                        //       maxLines: null,
                        //       minLines: 3,
                        //       controller: about,
                        //       // obscureText: true,
                        //       decoration: InputDecoration(
                        //         // fillColor: Theme.of(context).accentColor,
                        //         filled: true,
                        //         focusColor: Theme.of(context).accentColor,
                        //         // hoverColor: Theme.of(context).accentColor,
                        //         // hoverColor: Theme.of(context).accentColor,
    
                        //         // disabledBorder: InputBorder.none ,
                        //         fillColor: Colors.white,
                        //         border: OutlineInputBorder(
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(5.0),
                        //           ),
                        //         ),
                        //         alignLabelWithHint: true,
                        //         labelText: 'Descrição',
                        //       ),
                        //       // autofocus: true,
                        //     )),
                        formTextInput('Descrição', about, null, 3),
    
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text('Dados de contato'),
                        )),
    
                        formTextInput('Email', email, null, null),
    
                        formTextInput('Telefone', phone, null, null),
    
                        formTextInput(
                            'Instagram', instagram, 'https://instagram.com/', null),
    
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 10),
                        //     child: TextField(
                        //       // cursorColor: Theme.of(context).accentColor,
                        //       cursorColor: Theme.of(context).accentColor,
                        //       controller: phone,
    
                        //       // obscureText: true,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(5.0),
                        //           ),
                        //         ),
                        //         labelText: 'Telefone',
                        //       ),
                        //       // autofocus: true,
                        //     )),
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 10),
                        //     child: TextField(
                        //       // cursorColor: Theme.of(context).accentColor,
                        //       cursorColor: Theme.of(context).accentColor,
                        //       controller: phone,
    
                        //       // obscureText: true,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(5.0),
                        //           ),
                        //         ),
                        //         labelText: 'Instagram',
                        //       ),
                        //       // autofocus: true,
                        //     )),
                        // alignment: Alignment(1.0, 1.0),
                        RaisedButton(
                            color: Theme.of(context).accentColor,
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
    
      // Widget countryPhoneSelector() => Container(
      //         child: DropdownButton<String>(
      //       value: dropdownValue,
      //       icon: Icon(Icons.arrow_downward),
      //       iconSize: 24,
      //       elevation: 16,
      //       style: TextStyle(color: Colors.deepPurple),
      //       underline: Container(
      //         height: 2,
      //         color: Colors.deepPurpleAccent,
      //       ),
      //       onChanged: (String newValue) {
      //         setState(() {
      //           dropdownValue = newValue;
      //         });
      //       },
      //       items: <String>['One', 'Two', 'Free', 'Four']
      //           .map<DropdownMenuItem<String>>((String value) {
      //         return DropdownMenuItem<String>(
      //           value: value,
      //           child: Text(value),
      //         );
      //       }).toList(),
      //     ));
    
      Widget formTextInput(
              String label, TextEditingController type, prefix, lines) =>
          Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: <Widget>[
                  // opc != null ? opc() : Container(),
                  TextField(
                    keyboardType: lines != null
                        ? TextInputType.multiline
                        : TextInputType.text,
                    maxLines: null,
                    minLines: lines != null ? lines : 1,
                    // cursorColor: Theme.of(context).accentColor,
                    cursorColor: Theme.of(context).accentColor,
                    controller: type,
    
                    // obscureText: true,
                    decoration: InputDecoration(
                      prefixText: prefix != '' ? prefix : '',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      labelText: label,
                    ),
                    // autofocus: true,
                  )
                ],
              ));
    
    
}

class UploadFileInfo {}
