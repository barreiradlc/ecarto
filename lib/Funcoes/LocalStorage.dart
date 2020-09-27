import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:intl/intl.dart';

import 'Fetch.dart';

Future handleStoreChatData(id) async {
  var data = await fetchChatMessages(id);
  final count = data['messages'].length;
  final messages = data['messages'];
  final database = AppDatabase();

  for (var i = 0; i < count; i++) {
    print(messages[i]);
    
     final message = Message(
      id: messages[i]['_id'],
      body: messages[i]['body'],
      createdAt: DateTime.parse(messages[i]['createdAt']),
      sender: messages[i]['sender'],
      read: true,
      send: true
    );

    database.insertMessage(message);    
  }

  // data['messages'].map((Message message) {
  //   print(message);
  //   // database.insertMessage(message);
  // });

  return data['messages'];
}


Future handleStoreMessage(data) async {  
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



