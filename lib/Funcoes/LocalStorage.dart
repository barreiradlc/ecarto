import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'Fetch.dart';

Future handleStoreChatData(id) async {
  Get.dialog(alertWidget(),
        barrierDismissible: false, useRootNavigator: false);
  var data = await fetchChatMessages(id);

    final database = AppDatabase();
    var chatData = data;
    var photofrom = await getphotofrom(chatData['users']);
    var idfrom = await getIdfrom(chatData['users']);
    var namefrom = await getNamefrom(chatData['users']);      
    
    final chat = Chat(       
      id: chatData['_id'],
      de: namefrom,
      idOuter: idfrom,
      photofrom: photofrom
    );
        
    await database.insertChat(chat);

  final count = data['messages'].length;
  final messages = data['messages'];

  for (var i = 0; i < count; i++) {
    print(messages[i]);
    
     final message = Message(
      id: messages[i]['_id'],
      body: messages[i]['body'],
      createdAt: DateTime.parse(messages[i]['createdAt']),
      sender: messages[i]['sender'],
      chatId: chatData['_id'],
      read: true,
      send: true
    );

    database.insertMessage(message);    
  }

  Get.back();

  return chat;
}
// Future handleStoreChatData(id) async {
//   var data = await fetchChatMessages(id);
//   final count = data['messages'].length;
//   final messages = data['messages'];
//   final database = AppDatabase();

//   for (var i = 0; i < count; i++) {
//     print(messages[i]);
    
//      final message = Message(
//       id: messages[i]['_id'],
//       body: messages[i]['body'],
//       createdAt: DateTime.parse(messages[i]['createdAt']),
//       sender: messages[i]['sender'],
//       read: true,
//       send: true
//     );

//     database.insertMessage(message);    
//   }
//   return data['messages'];
// }

getphotofrom(users) async{
  var localId = await void_getID();
  var count = users.length;

  for (var i = 0; i < count; i++) {
    if(localId != users[i]['_id']){
      return users[i]['image'];
    }
  }
}

getIdfrom(users) async{
  var localId = await void_getID();
  var count = users.length;

  for (var i = 0; i < count; i++) {
    if(localId != users[i]['_id']){
      return users[i]['_id'];
    }
  }
}

getNamefrom(users) async{
  var localId = await void_getID();
  var count = users.length;

  for (var i = 0; i < count; i++) {
    if(localId != users[i]['_id']){
      return users[i]['name'];
    }
  }
}

Future handleStoreChatsListData() async {
  // TODO - Chamada de chats

  var data = await fetchChats();

  final count = data.length;
  final chats = data;
  final database = AppDatabase();

  for (var i = 0; i < count; i++) {
    var chatData = chats[i];
    var photofrom = await getphotofrom(chatData['users']);
    var idfrom = await getIdfrom(chatData['users']);
    var namefrom = await getNamefrom(chatData['users']);      
    
     final chat = Chat(       
      id: chatData['_id'],
      de: namefrom,
      idOuter: idfrom,
      photofrom: photofrom
    );
        
    await database.insertChat(chat);

    var messageCount = chatData['messages'].length;
    final messages = chatData['messages'];

      for (var i = 0; i < messageCount; i++) {
        handleStoreMessage(messages[i], chatData['_id']);
      }
  }
  return data;
  }


Future handleStoreMessage(data, chatId) async {  
    final database = AppDatabase();

     final message = Message(
      id: data['_id'],
      chatId: chatId,
      body: data['body'],
      createdAt: DateTime.parse(data['createdAt']),
      sender: data['sender'],
      read: true,
      send: true
    );

    database.insertMessage(message);    

    return message;
  }

  Future handleStoreChat(data) async {
    final database = AppDatabase();

     final message = Message(

      id: data['_id'],
      body: data['body'],
      createdAt: DateTime.parse(data['createdAt']),
      sender: data['sender'],
      read: true,
      send: true
    );

    database.insertMessage(message);    

    return message;
  }

Future handleStoreMessages(data) async {  
    final database = AppDatabase();

     final message = Message(
      id: data['_id'],
      body: data['body'],
      createdAt: DateTime.parse(data['createdAt']),
      sender: data['sender'],
      read: true,
      send: true
    );

    database.insertMessage(message);    

    return message;
  }



