import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/LocalStorage.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
// import 'package:ecarto/Widgets/ListChatRooms.dart';
import 'package:ecarto/Widgets/ListChatRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var chatRoomData;
  var chatRoom;
  var id;

  String chatRoomOuter;
  String chatRoomouterPhoto;

  @override
  void initState() {
    super.initState();

    getChatRoomData();
  }

  getChatRoomData() async{
    String chatRoomId = Get.parameters['id'];
    String roomOuter = Get.parameters['de'];
    String roomouterPhoto = Get.parameters['photofrom'];
    String localId = await void_getID();

    // var data = await handleStoreChatRoomData(ChatRoomId);

    setState(() {
      chatRoom = chatRoomId;
      id = localId;
      // chatRoomData = data;
      chatRoomOuter = roomOuter;
      chatRoomouterPhoto = roomouterPhoto;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Provider(
      // The single instance of AppDatabase
      builder: (_) => AppDatabase(),
      child: Container(            
        height: MediaQuery.of(context).size.height,
        child: ListChatRoom(id, chatRoom, chatRoomOuter, chatRoomouterPhoto),
      ),
    );
  }

  

}