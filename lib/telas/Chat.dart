import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/LocalStorage.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:ecarto/Widgets/ListChat.dart';
// import 'package:ecarto/Widgets/ListChatRooms.dart';
import 'package:ecarto/Widgets/ListChatRoom.dart';
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
  var chatRoomData;
  var chatRoom;
  var id;

  @override
  void initState() {
    super.initState();

    getChatData();
  }

  getChatData() async{
    // String chatRoomId = Get.parameters['id'];
    String localId = await void_getID();

    handleStoreChatsListData();

    setState(() {
      // chatRoom = chatRoomId;
      id = localId;
      // chatRoomData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      // The single instance of AppDatabase
      builder: (_) => AppDatabase(),
      child: Container(  
        color: Colors.blue,         
        height: MediaQuery.of(context).size.height,
        child: ListChat(id),
      ),
    );
  }

  

}