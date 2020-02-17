import 'package:flutter/material.dart';

void main() {
  runApp(Wikis());
}

class Wikis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: title,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(title),
        // ),
        body: new ListView.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: Container(
                        child: Text("Olar"),
                        padding: const EdgeInsets.all(2),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
