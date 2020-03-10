import 'dart:convert';

import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Tabs.dart';

import 'package:universal_html/prefer_universal/html.dart' as web;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import '../Funcoes/UserData.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeState(),
    );
  }
}

class HomeState extends StatefulWidget {
  @override
  CollapsingList createState() => CollapsingList();
}

class CollapsingList extends State<HomeState> {
  var materiais;
  var artes;
  bool loading = true;
  String token = 'testeJWT';
  String login = '';
  int id;

  var myPref = web.window.localStorage['mypref'];

  getData() async {
    
    final authJwt = await SharedPreferences.getInstance();

    String token = await authJwt.getString("jwt");
    String login = await authJwt.getString("username");
    int id = await authJwt.getInt("id");

    var responseArtes = await http.get(Uri.encodeFull(host + '/arte'),
        headers: {"Authorization": token});

    var responseMateriais = await http.get(Uri.encodeFull(host + '/material'),
        headers: {"Authorization": token});

    setState(() {
      this.token = token;
      this.login = login;
      this.id = id;
      artes = jsonDecode(responseArtes.body);
      materiais = jsonDecode(responseMateriais.body);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          itemExtent: height,
          delegate: SliverChildListDelegate(
            [
              Tabs(this.id, this.token, this.login, artes, materiais),
              // Container(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0)),
            ],
          ),
        ),
      ],
    );
  }
}
