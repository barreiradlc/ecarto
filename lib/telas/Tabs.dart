import 'dart:convert';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:http/http.dart' as http;

import 'package:ecarto/Recursos/Api.dart';
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

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.brush), child: Text('Artes', style: TextStyle(fontWeight: FontWeight.bold ),)),
    Tab(icon: Icon(Icons.extension), child: Text('Materiais', style: TextStyle(fontWeight: FontWeight.bold),)),
  ];

  TabController _tabController;

  bool _activeTabIndex = true;
  bool loading = true;
  var bg = AssetImage("assets/logo-white.png");



  var materiais;
  var artes;
  String username = '';

  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = _tabController.index == 0 ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    if (mounted) {
      setState(() {
        loading = false;
      });
      print('widget.materiais');
      print(widget.artes);
      print(widget.materiais);
      print('widget.materiais');
      // await getData();
      _tabController.addListener(_setActiveTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var drawerScaff = Drawer(      
      elevation: 3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(            
            child: Text("Bem Vindo(a): ${widget.login}"),
            decoration: BoxDecoration(
              color: Colors.white,              
              image: DecorationImage(
                image: bg,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    _activeTabIndex ? Theme.of(context).primaryColor.withOpacity(0.5) : Theme.of(context).accentColor.withOpacity(0.5),
                    BlendMode.color),
              ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            title: Text('Estoque'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/estoque');
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              

              removeLoginData().then((response) {
                
                print('LOGOUT');
                print(response);
                print('LOGOUT');

                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              });

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
        data: ThemeData(            
            accentColor: Colors.black,
            primaryColor: _activeTabIndex ? Theme.of(context).primaryColor : Theme.of(context).accentColor
        ),
        child: Scaffold(

          drawer: drawerScaff,
          appBar: AppBar(
            brightness: Brightness.dark, // status bar brightness
            iconTheme: new IconThemeData(color: Colors.white),
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            // When the user presses the button, show an alert dialog containing
            // the text that the user has entered into the text field.
            foregroundColor: Colors.white,
            backgroundColor: _activeTabIndex ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
            onPressed: () {
              Navigator.pushNamed(context, '/itens/form', arguments: _activeTabIndex ? "arte" : "material");
            },
            tooltip: _activeTabIndex ? "Criar Arte" : "Criar Material",
            child: Icon(Icons.add),
          ),
          body: TabBarView(

            controller: _tabController,
            // children: myTabs.map((Tab tab) {
            //   final String label = tab.text.toLowerCase();
            //   return Center(
            //     child: Text(
            //       'This is the $label tab',
            //       style: const TextStyle(fontSize: 36),
            //     ),
            //   );
            // }).toList(),
            children: [
              // Wikis(),
              Artes(widget.artes),
              Materiais(widget.materiais),
            ],
          ),
        ));

    // return Theme(
    //     data: ThemeData(primaryColor: _activeTabIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).accentColor),
    //     child: DefaultTabController(
    //         length: 2,
    //         child: Scaffold(
    //           drawer: drawerScaff,
    //           appBar: AppBar(
    //             bottom: tabs(),
    //             // automaticallyImplyLeading: false,
    //             // title: RaisedButton(onPressed: () => { drawerScaff.build(context) }),
    //           ),
    //           body: TabBarView(
    //             children: [
    //               // Wikis(),
    //               Artes(widget.artes),
    //               Materiais(widget.materiais),
    //             ],
    //           ),
    //         )));
  }
}

Widget tabs() {
  return TabBar(
    indicatorColor: Colors.green,
    onTap: (index) => {print('pokebola vai $index')},
    tabs: [
      // Tab(icon: Icon(Icons.collections_bookmark), child: Text('Wikis')),
      Tab(icon: Icon(Icons.brush), child: Text('Artes')),
      Tab(icon: Icon(Icons.extension), child: Text('Materiais')),
    ],
  );
}
