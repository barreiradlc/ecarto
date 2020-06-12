import 'dart:convert';

import 'package:ecarto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/prefer_universal/html.dart' as web;

import './Tabs.dart';
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

  getLocation() async {
    var p = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('p');
    print(p);
    print(p.latitude);
    return p;
  }

  getData() async {
    getLocation().then((location) {
      void_getJWT().then((jwt) async {
        final authJwt = await SharedPreferences.getInstance();

        String token = await authJwt.getString("jwt");
        String login = await authJwt.getString("username");
        var id = await authJwt.getInt("id");

        print(token);
        print(login);
        print(id);

        // longitude=long&latitude=lat&radius=20
        var long = location.latitude;
        var lat = location.longitude;

        print(lat);
        print(long);

        var responseArtes = await http.get(
            Uri.encodeFull(
                host + '/arte?longitude=$long&latitude=$lat&radius=20'),
            headers: {"Authorization": token}); 

        var responseMateriais = await http.get(
            Uri.encodeFull(
                host + '/material?longitude=$long&latitude=$lat&radius=20'),
            headers: {"Authorization": token});

        print('url');
        print(host + '/material?longitude=$long&latitude=$lat&radius=20');

        setState(() {
          this.token = token;
          this.login = login;
          this.id = id;
          artes = jsonDecode(responseArtes.body);
          materiais = jsonDecode(responseMateriais.body);
          loading = false;
        });
      })
      .catchError((err) {
        print('erro em jwt');
        print(err);
      });
    })
    .catchError((err) {
      print('erro em location');
      print(err);
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
