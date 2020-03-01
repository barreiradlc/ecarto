import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Home/Wikis.dart';
import './Home/Materiais.dart';
import './Home/Artes.dart';

import '../Funcoes/UserData.dart';

class Tabs extends StatefulWidget {
  var tema = 0;
  final id;
  final token;
  final login;
  final artes;
  final materiais;
  Tabs(this.id, this.token, this.login, this.artes, this.materiais);

  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  bool loading = true;
  var bg = AssetImage("assets/logo.png");
  var materiais;
  var artes;
  String username = '';

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        loading = false;
      });
      print('widget.materiais');
      print(widget.artes);
      print(widget.materiais);
      print('widget.materiais');
      // await getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerScaff = Drawer(
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Bem Vindo(a); ${widget.login}"),
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

    if (loading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
      ));
    }

    return Theme(
        data: ThemeData(primaryColor: Colors.green),
        child: DefaultTabController(
          
            length: 2,
            child: Scaffold(
              drawer: drawerScaff,
              appBar: AppBar(
                
                

                
                bottom: tabs(),
                // automaticallyImplyLeading: false,
                // title: RaisedButton(onPressed: () => { drawerScaff.build(context) }),
              ),
              
              body: TabBarView(
                children: [
                  // Wikis(),
                  Artes(widget.artes),
                  Materiais(widget.materiais),
                ],
              ),
            )));
  }
}

Widget tabs() {
  return TabBar(
    indicatorColor: Colors.white,
    onTap: (index) => {print('pokebola vai $index')},
    tabs: [
      // Tab(icon: Icon(Icons.collections_bookmark), child: Text('Wikis')),
      Tab(icon: Icon(Icons.brush), child: Text('Artes')),
      Tab(icon: Icon(Icons.extension), child: Text('Materiais')),
    ],
  );
}
