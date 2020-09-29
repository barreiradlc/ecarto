import 'package:ecarto/Funcoes/ConvertDate.dart';
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListChat extends StatefulWidget {
  
  final id;

  // ListChat(this.id);
  ListChat(this.id, {Key key}) : super(key: key);

  @override
  _ListChatsStat createState() => _ListChatsStat();
}

class _ListChatsStat extends State<ListChat> {
  @override
  Widget build(BuildContext context) {
    var localId = widget.id;
    final newChat = TextEditingController(text: '');
    
    submitChat() {      
      return;
    }

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildChatList(context, localId)),            
            // NewTaskInput(),
          ],
        ));
  }
}

StreamBuilder<List<Chat>> _buildChatList(
    BuildContext context, String localId) {
  final database = Provider.of<AppDatabase>(context);
  return StreamBuilder(
    stream: database.watchAllChats(),
    builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
      final chats = snapshot.data ?? List();

      return ListView.builder(
        shrinkWrap: true,
        itemCount: chats.length,
        itemBuilder: (s_, index) {
          final itemTask = chats[index];
          return _buildListItem(itemTask, database, localId);
        },
      );
    },
  );
}

Widget _buildListItem(Chat itemChat, AppDatabase database, String localId) {
  bool self = true;

  print('self?');
  print(self);

  if (localId == null) {
    return Center(
      heightFactor: 65,
      child: LinearProgressIndicator(),
    );
  }

  return Card(    
    color: Colors.white,
    margin:
        EdgeInsets.only(left: 10, right: 10, top: 15),
    child: Container(      
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(        
        leading: itemChat.photofrom != "" || null ? Image.network(itemChat.photofrom, ) : Icon(Icons.person),
        title: Text(itemChat.de,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.start),
      ),
    ),
  );

  // return Slidable(
  //   actionPane: SlidableDrawerActionPane(),
  //   // child: Card(child: Text(itemChat.body)),
  //   secondaryActions: <Widget>[
  //     IconSlideAction(
  //       caption: 'Remover',
  //       color: Colors.red,
  //       icon: Icons.delete,
  //       // TODO - Avaliar
  //       // onTap: () => database.deleteTask(itemChat),
  //     )
  //   ],
  //   // TODO - Avaliar embasamento
  //   child: ListTile(
  //     title: Text(itemChat.body),
  //     subtitle: Text(convertDatetimetoPT(itemChat.createdAt) ?? 'No date'),
  //     // value: itemChat.read,
  //     // TODO - Avaliar embasamento
  //     // onChanged: (newValue) {
  //     //   database.updateTask(itemChat.copyWith(read: newValue));
  //     // },
  //   ),
  // );
}
