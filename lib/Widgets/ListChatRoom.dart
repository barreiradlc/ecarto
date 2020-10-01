import 'package:ecarto/Funcoes/ConvertDate.dart';
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListChatRoom extends StatefulWidget {
  final id;
  final chatRoom;
  final chatRoomuOter;
  final chatRoomouterPhoto;

  // ListChatRoom(this.id);
  ListChatRoom(this.id, this.chatRoom, this.chatRoomuOter, this.chatRoomouterPhoto, {Key key}) : super(key: key);

  @override
  _ListChatRoomsStat createState() => _ListChatRoomsStat();
}

class _ListChatRoomsStat extends State<ListChatRoom> {
  @override
  Widget build(BuildContext context) {
    var localId = widget.id;
    var chatRoom = widget.chatRoom;
    final newMessage = TextEditingController(text: '');
    String chatRoomuOter = widget.chatRoomuOter;
    String chatRoomouterPhoto = widget.chatRoomouterPhoto;
    
    submitMessage() {
      String message = newMessage.text;
      if (message != '') {
        setState(() {
          newMessage.text = "";
        });
        var response = sendMessage(message, widget.chatRoom);
        if(response == null){
          setState(() {
            newMessage.text = message;
          });
        }
      }
      return;
    }

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                decoration: BoxDecoration(         

                  borderRadius: BorderRadius.all(
                    Radius.circular(80.0),
                  ),
                ),
                width: 70, height: 50,
                child: chatRoomouterPhoto != "" || chatRoomouterPhoto != null ? Image.network(chatRoomouterPhoto) : Icon(Icons.person),                
              ),
              Text(
                '$chatRoomuOter',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),          
          
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildMessageList(context, localId, chatRoom)),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(                       
                          textInputAction: TextInputAction.newline,

                          // textInputAction: TextInputAction.send,
                          // onSubmitted: () => print('alou'),//submitMessage(), // move focus to next
                          controller: newMessage,
                          decoration: InputDecoration(
                            labelText: 'Mensagem',
                          ),
                        ),
                      ),                      
                      FlatButton(                        
                          onPressed: submitMessage,
                          child: Icon(
                            Icons.send,
                            size: 25,
                          ))
                    ],
                  )),
            )
            // NewTaskInput(),
          ],
        ));
  }
}

StreamBuilder<List<Message>> _buildMessageList(
    BuildContext context, String localId, String chatRoom) {
  final database = Provider.of<AppDatabase>(context);
  return StreamBuilder(
    stream: database.watchAllMessages(chatRoom),
    builder: (context, AsyncSnapshot<List<Message>> snapshot) {
      final messages = snapshot.data ?? List();

      return ListView.builder(
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (s_, index) {
          final itemTask = messages[index];
          return _buildListItem(itemTask, database, localId, chatRoom);
        },
      );
    },
  );
}

Widget _buildListItem(
    Message itemMessage, AppDatabase database, String localId, String chatRoom) {
  bool self = itemMessage.sender == localId;

  print('self?');
  print(self);

  if (localId == null) {
    return Center(
      heightFactor: 65,
      child: LinearProgressIndicator(),
    );
  }

  // if(chatRoom != itemMessage.chatId){
  //   return null;
  // }

  return Card(
    color: self ? Color(0xff42A5F5) : Color(0xff558b2f),
    margin:
        EdgeInsets.only(left: self ? 35 : 10, right:!self ? 35 : 10, top: 10),
    child: ListTile(
      title: Text(itemMessage.body,
          style: TextStyle(color: Colors.white),
          textAlign: self ? TextAlign.end : TextAlign.start),
      subtitle: Text(
        convertDatetimetoPT(itemMessage.createdAt) ?? 'No date',
        style: TextStyle(fontSize: 10, color: Colors.white),
        textAlign: self ? TextAlign.end : TextAlign.start,
      ),
    ),
  );

  // return Slidable(
  //   actionPane: SlidableDrawerActionPane(),
  //   // child: Card(child: Text(itemMessage.body)),
  //   secondaryActions: <Widget>[
  //     IconSlideAction(
  //       caption: 'Remover',
  //       color: Colors.red,
  //       icon: Icons.delete,
  //       // TODO - Avaliar
  //       // onTap: () => database.deleteTask(itemMessage),
  //     )
  //   ],
  //   // TODO - Avaliar embasamento
  //   child: ListTile(
  //     title: Text(itemMessage.body),
  //     subtitle: Text(convertDatetimetoPT(itemMessage.createdAt) ?? 'No date'),
  //     // value: itemMessage.read,
  //     // TODO - Avaliar embasamento
  //     // onChanged: (newValue) {
  //     //   database.updateTask(itemMessage.copyWith(read: newValue));
  //     // },
  //   ),
  // );
}

Future getUserData() async {
  String id = await void_getID();

  return id;
}
