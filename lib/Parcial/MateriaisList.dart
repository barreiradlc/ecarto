import 'package:flutter/material.dart';

class MateriaisList extends StatefulWidget {
  @override
  MateriaisLisState createState() => new MateriaisLisState();
}

class MateriaisLisState extends State<MateriaisList> {
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Item'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Item'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Item'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Item'),
            ),
        ],
      )
    );
  }
}
