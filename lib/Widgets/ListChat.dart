import 'package:dio/dio.dart';
import 'package:ecarto/Funcoes/ConvertDate.dart';
import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserData.dart';
import 'package:ecarto/Recursos/DB/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListChat extends StatefulWidget {
  
  final id;

  // ListChat(this.id);
  ListChat(this.id, {Key key}) : super(key: key);

  @override
  _ListChatsStat createState() => _ListChatsStat();
}

class _ListChatsStat extends State<ListChat> {

  String imgUrl;

  @override
  void initState() { 
    super.initState();
    
    getThumb();
  }


  getThumb() async {
    var url = 'https://source.unsplash.com/random/?craft';
    // var url = 'https://dog.ceo/api/breeds/image/random';

    Dio dio = new Dio();

    var response = await dio.get(url);

    print('realUri');
    print(response.realUri);

    setState(() {
      imgUrl = response.realUri.toString();
    });

    return response.realUri;
  }

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
            Expanded(child: _buildChatList(context, localId, imgUrl)),            
            // NewTaskInput(),
          ],
        ));
  }
}

StreamBuilder<List<Chat>> _buildChatList(
    BuildContext context, String localId, String imgUrl) {
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
          return _buildListItem(itemTask, database, localId, imgUrl);
        },
      );
    },
  );
}

Widget _buildListItem(Chat itemChat, AppDatabase database, String localId, String imgUrl) {
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
          onTap: () {
            Get.toNamed('/chat/${itemChat.id}?de=${itemChat.de}&photofrom=${itemChat.photofrom}', arguments: itemChat );
          },     
  
          leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius:
  25,
                                  backgroundImage: NetworkImage(
                                      itemChat.photofrom == null ||
                                              itemChat.photofrom == ''
                                          ? imgUrl
                                        : itemChat.photofrom),
                              ),
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
