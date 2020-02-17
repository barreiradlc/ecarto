import 'package:flutter/material.dart';
import './Tabs.dart';

import 'package:universal_html/prefer_universal/html.dart' as web;

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math' as math;

import '../Funcoes/UserData.dart';
// Tabs(),

void main() => runApp(Home());

class Home extends StatelessWidget {
  

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: RaisedButton(onPressed: () => { drawerScaff.build(context) })),
      // drawer: drawerScaff,
      body: HomeState(),
    );
  }
}

class HomeState extends StatefulWidget {
  @override
  CollapsingList createState() => CollapsingList();
}

class CollapsingList extends State<HomeState> {
  String jwt = 'testeJWT';
  String username = '';

  var myPref = web.window.localStorage['mypref'];

  @override
  Widget build(BuildContext context) {
    Future<String> _getJWT() async {
      final authJwt = await SharedPreferences.getInstance();
      String jwt = authJwt.getString("jwt");
      String username = authJwt.getString("username");
      setState(() {
        this.jwt = jwt;
        this.username = username;
      });
      print(username);
      // this.jwt = jwt2;
      return jwt;
    }

    double height = MediaQuery.of(context).size.height;

    if (this.username == '') {
      _getJWT();
    }

    @override
    void initState() {
      _getJWT();
      super.initState();
      // Add listeners to this class
      getUser().then((username) {
        print(username);
        setState(() {
          this.username = username;
        });
      });
    }

    // return CustomScrollView(
    //   slivers: <Widget>[
    //     // makeHeader(myPref),
    //     makeHeader('Seja bem vindo(a): ' + this.username),

    //     // makeHeader2('Camera'),

    //     SliverGrid.count(
    //       crossAxisCount: 1,
    //       children: [
    //         Tabs(),
    //       ],
    //     ),
    //   ],
    // );

    return CustomScrollView(
      slivers: <Widget>[

        // SliverAppBar(
        //   title: Text(
        //     'Seja bem vindo(a): ' + this.username + "!",
        //     textAlign: TextAlign.start,
        //     overflow: TextOverflow.ellipsis,
        //     style:
        //         TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
        //   ),

        //   // backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
        //   backgroundColor: Colors.green,
        //   expandedHeight: 200.0,
        //   automaticallyImplyLeading: false,
        //   flexibleSpace: FlexibleSpaceBar(
        //     background: Container(
        //       color: Colors.blue,
        //     ),
        //   ),
        // ),

        SliverFixedExtentList(
          itemExtent: height,
          delegate: SliverChildListDelegate(
            [
              Tabs(),
              // Container(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0)),
            ],
          ),
        ),
      ],
    );
  }
}
