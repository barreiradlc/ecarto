import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/LocalStorage.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Parcial/Carousel.dart';
import 'package:ecarto/Parcial/MateriaisList.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../main.dart';

import 'package:intl/intl.dart';

class DetailItemScreen extends StatefulWidget {
  @override
  DetailItems createState() => new DetailItems();
}

class DetailItems extends State<DetailItemScreen> {
  var autor;
  var jwt;
  var id;

  @override
  void initState() {
    super.initState();

    void_getID().then((id) {
      print('ID USER');
      print(id);
      print('ID USER');
      setState(() {
        this.id = id;
      });
    });

    void_getJWT().then((jwt) {
      print(jwt);
      setState(() {
        jwt = jwt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark));

    // var todo = ModalRoute.of(context).settings.arguments;
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;
    String formatDate(DateTime date) =>
        new DateFormat("MMMM d").format(item.updated_at);
    String update = DateFormat('dd/MM/y kk:mm').format(item.updated_at);

    var thumb;
    var passoAPasso;
    var botAcao;

    print('item');
    print(item.nature);
    print(item.index);

    if (item.thumbnail != null) {
      thumb = Hero(
          tag: 'Thumbnail${item.index}',
          child: Image.network(item.thumbnail,
              fit: BoxFit.cover, alignment: Alignment.center));
    } else {
      thumb = Image.asset('assets/logo.png', fit: BoxFit.cover);
    }

    removeImage(image) async {
      Dio dio = new Dio();

      print(dio);

      var response = await dio.get('$hostImg/img/$image');

      print('UPLOAD');
      print(response);
      print(response.data);
      print('UPLOAD');

      return response.data['img'];
    }    

    delete(id) async {
      final authJwt = await SharedPreferences.getInstance();
      String token = await authJwt.getString("jwt");

      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //         // Retrieve the text the that user has entered by using the
      //         content: Container(
      //             padding: EdgeInsetsDirectional.only(top: 50),
      //             height: 150,
      //             child: Column(
      //               children: <Widget>[
      //                 CircularProgressIndicator(),
      //                 Text(
      //                   "Aguarde...",
      //                 )
      //               ],
      //             )));
      //   },
      // );

      Get.dialog(alertWidget(),
          barrierDismissible: false, useRootNavigator: false);

      print(token);
      var endpoint = '/items/$id';

      print(endpoint);

      if (item.thumbnail != null) {
        removeImage(item.thumbnail);
      }

      var response = await http.delete('$host$endpoint',
          headers: {"Authorization": 'Bearer $token'});

      print(response);

      print('###');
      print(response.statusCode);
      print(response.toString());
      // var res = jsonDecode(response.body);
      // print(res);
      print('###');

      Get.back();

      Get.toNamed('/home');
      // Navigator.pushReplacementNamed(context, '/home');
    }

    back() {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    }

    deleteAction(idItem) {
      return delete(idItem);

      Get.dialog(Container(
          color: Colors.white24.withOpacity(0.5),
          height: MediaQuery.of(context).size.height / 2,
          child: Scaffold(

              // backgroundColor: Colors.white.withOpacity(0.5),
              body: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Deseja realmente remover? \n \n'),
                // Text('$idItem'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () => delete(idItem),
                        child: Text('Remover')),
                    RaisedButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () => back(),
                        child: Text('Cancelar'))
                  ],
                )
              ],
            ),
          ))));
    }

    editAction(item) {
      print('item.thumbnail');
      print(item.thumbnail);
      Navigator.pushNamed(
        context,
        '/itens/form',
        arguments: ScreenArguments(
            item.title,
            item.description,
            item.thumbnail,
            null, // DateTime.parse(widget.artes[index]['updated_at']),
            item.nature,
            item.user_id,
            item.id,
            item.price,
            item.index),
      );
    }

    goToChat(id, context) async{
      final database = AppDatabase();
      
      var chat = await database.getChat(id);
      var chats = await database.getAllChats();

      
      print(chat);
      if(chat != null){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return Get.toNamed('/chat/${chat.id}?de=${chat.de}&photofrom=${chat.photofrom}', arguments: chat );
      }

      var newChat = await handleStoreChatData(id);
      
      if(newChat != null){
        Navigator.of(context).pop();
        Navigator.of(context).pop();          
        Get.toNamed('/chat/${newChat.id}?de=${newChat.de}&photofrom=${newChat.photofrom}', arguments: newChat );          
      }
        
      

      // TODO - Criar sala
    }

    goToProfile(id, context){      
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Get.toNamed('/perfil/${id}');
    }

    profileMgsModal(id){
      print('Autor $id');
      
      return showDialog(
      context: context,
      builder: (context) {
        return Card(                      
            color: Colors.transparent,
            child: AlertDialog(              
            content:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  onPressed: () => goToProfile(id, context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      Text("Ver Perfil", style: TextStyle(fontSize: 12),)
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => goToChat(id, context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.message),
                      Text("Enviar mensagem", style: TextStyle(fontSize: 12))
                    ],
                  ),
                )
              ],
            ),
          ),        
        
        );
      }
      );
      
      
    }

    alertAutor() {
      double dividerHeigth = 20;
      var dividerColor = item.nature == 'ARTE'
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor;
      var textColor = item.nature != 'ARTE'
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor;

      print('autor');
      print(autor['email']);
      print('autor');
      // print(autor.email);

      return showDialog(
      context: context,
      builder: (context) {
        return Card(            
            color: Colors.transparent,
            child: AlertDialog(
            content: Container(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(),
              ListTile(
                onTap: () => profileMgsModal(autor['_id']) ,
                title: Text(autor['name'] != '' && autor['name'] != null ? autor['name'] : autor['username'],
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
              autor['phone'] != "" && autor['phone'] != null
                  ? ListTile(
                      onTap: () => launch(
                          "https://wa.me/55${autor['phone']}?text=Olá%20te%20Encontrei%20no%20Ecarto%20pelo post: ${item.title}"),
                      title: Text('Telefone: ' + autor['phone']),
                    )
                  : Container(),
              Divider(),
              autor['email'] != "" && autor['email'] != null
                  ? ListTile(
                      onTap: () => launch(
                          "mailto:${autor['email']}?subject=Contato do app Ecarto sobre a publicação: ${item.title}"),
                      title: Text('Email: ' + autor['email']),
                    )
                  : Container(),
              Divider(),
              // Divider(height: dividerHeigth),
              autor['instagram'] != "" && autor['instagram'] != null
                  ? ListTile(
                      onTap: () =>
                          launch("https://instagram.com/${autor['instagram']}"),
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
          )
          )
          )
          )                  
          );                  
          }
          );
    }

    Future<String> contatarAutor(userId) async {
      Get.dialog(alertWidget(msg: "Buscando dados do autor"),
          barrierDismissible: false, useRootNavigator: false);

      void_getJWT().then((token) async {
        print(token);
        // print(item.title);
        print(userId);
        Dio dio = new Dio();
        // dio.options.headers['content-Type'] = 'application/json';
        dio.options.headers["authorization"] = 'Bearer $token';
        // dio.options.headers["authorization"] = "token ${token}";
        var response = await dio.get('$host/user?outerUserId=$userId');
        // print(response);
        print('response.data');
        print(response.data);
        print('response.data');

        setState(() {
          autor = response.data;
        });

        Navigator.pop(context);
        alertAutor();
      });

      // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
      //     headers: {"Authorization": jwt});

      // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
      //   headers: {"Authorization": jwt});

      // Response response;
      // Dio dio = new Dio();
      // response = await dio.get("/test?id=12&name=wendu");
      // print(response.data.toString());
// Optionally the request above could also be done as
      // response =
      //     await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
      // print(response.data.toString());

      // print(jsonDecode(response.body));
      // print(response.body);

      // print(response.body);

      return "Sucesso";
    }

    // if (item.steps.length != 0) {
    //   passoAPasso = RaisedButton(
    //     padding: EdgeInsets.all(20),
    //     onPressed: () {
    //       showFancyCustomDialog(context);
    //     },
    //     color: Colors.white,
    //     child: Text("Passo a passo"),
    //   );
    // } else {
    //   passoAPasso = RaisedButton(
    //       padding: EdgeInsets.all(20),
    //       onPressed: () {
    //         // showFancyCustomDialog(context);
    //       },
    //       color: Colors.white70,
    //       child: Text("Passo a passo indisponível",
    //           style: TextStyle(color: Colors.white)));
    // }

    print(item.nature);

    botAcao = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Icon(Icons.edit), Text("Editar ")],
            ),
            onPressed: () => editAction(item)),
        RaisedButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.delete), Text("Excluir ")],
            ),
            onPressed: () => deleteAction(item.id))
      ],
    ));

    if (item.user_id != id) {
      botAcao = Container(
          margin: EdgeInsets.all(20),
          child: RaisedButton(
              padding: EdgeInsets.all(15),
              color: item.nature == 'ARTE'
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.chat, color: Colors.white),
                  Text("   Contatar autor",
                      style: TextStyle(color: Colors.white))
                ],
              ),
              onPressed: () => contatarAutor(item.user_id)));
    }

    return Theme(
        data: new ThemeData(
            primaryColor: item.nature == 'ARTE'
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            brightness: Brightness.dark,
            title: Text(item.title, style: TextStyle(color: Colors.white)),
          ),
          body: Padding(
              padding: EdgeInsets.all(0),
              child: new ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Container(height: 250.0, child: thumb),
                ),
                Padding(
                  padding: EdgeInsets.all(25),

                  child: Text(item.description), //
                ),
                item.price != 0
                    ? Padding(
                        padding: EdgeInsets.all(25),
                        child: Hero(
                          tag: 'Price${item.id}',
                          child: Text('Preço: R\$ ${item.price.toString()}'), //
                        ))
                    : Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('Preço: Gratuito'), //
                      ),
                botAcao,
                // MateriaisList(),
                // passoAPasso,
                Container(
                  alignment: Alignment(1.0, 1.0),
                  padding: EdgeInsets.fromLTRB(5, 45, 15, 5),
                  child: Text("Última atualização em: " + update), //
                )
              ])),
        ));
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
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              // child: CarouselList(item.steps),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).accentColor,
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
