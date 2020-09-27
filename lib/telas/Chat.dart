import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/LocalStorage.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:ecarto/Widgets/ListChats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var chats;
  var chat;
  var id;

  @override
  void initState() {
    super.initState();

    getChatData();
  }

  getChatData() async{
    String chatId = Get.parameters['id'];
    String localId = await void_getID();

    var data = await handleStoreChatData(chatId);

    setState(() {
      chat = chatId;
      id = localId;
      chats = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      // The single instance of AppDatabase
      builder: (_) => AppDatabase(),
      child: Container(            
        height: MediaQuery.of(context).size.height,
        child: ListChats(id, chat),
      ),
    );
  }

  

}