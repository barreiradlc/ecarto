import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChatStream extends StatefulWidget {
  final chatRoom;

  ChatStream(this.chatRoom);

  @override
  _ChatStreamState createState() => _ChatStreamState();
}

class _ChatStreamState extends State<ChatStream> {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  final newMessage = TextEditingController(text: '');

  submitMessage() {
    
    return _sendMessage();

    String message = newMessage.text;
    if (message != '') {
      setState(() {
        newMessage.text = "";
      });
      var response = sendMessage(message, widget.chatRoom);
      if (response == null) {
        setState(() {
          newMessage.text = message;
        });
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              
              // TODO - Tratar db local

              return Container();
              // return Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 24.0),
              //   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              // );

            },
          ),
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
      ),
    );
  }

  void _sendMessage() {
    if (newMessage.text.isNotEmpty) {
      channel.sink.add(newMessage.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

}
