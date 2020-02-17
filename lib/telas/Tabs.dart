import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Home/Wikis.dart';
import './Home/Materiais.dart';
import './Home/Artes.dart';

import '../Funcoes/UserData.dart';

void main() {
  runApp(Tabs());
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  var bg = AssetImage("assets/logo.png");

  String username = '';

  @override
  Widget build(BuildContext context) {
    Future<String> _getJWT() async {
      final authJwt = await SharedPreferences.getInstance();
      String username = authJwt.getString("username");
      setState(() {
        this.username = username;
      });
      print(username);
    }

    if (this.username == '') {
      _getJWT();
      print(this.username);
    }

    @override
    void initState() {
      _getJWT();
      super.initState();
      // Add listeners to this class
      getUser().then((username) {
        print(username);
        setState(() {
          username = username;
        });
      });
    }

    var drawerScaff = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Bem Vindo " + this.username),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: bg,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
              ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            title: Text('Estoque'),
            onTap: () {
              Navigator.pushNamed(context, '/estoque');
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: drawerScaff,
        appBar: AppBar(
          bottom: tabs(),
          // automaticallyImplyLeading: false,
          // title: RaisedButton(onPressed: () => { drawerScaff.build(context) }),
        ),
        body: TabBarView(
          children: [
            Wikis(),
            Artes(),
            Materiais(),
          ],
        ),
      ),
    );
  }
}

Widget tabs() {
  return TabBar(
    tabs: [
      Tab(icon: Icon(Icons.collections_bookmark), child: Text('Wikis')),
      Tab(icon: Icon(Icons.brush), child: Text('Artes')),
      Tab(icon: Icon(Icons.extension), child: Text('Materiais')),
    ],
  );
}
