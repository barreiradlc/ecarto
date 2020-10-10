import 'dart:convert';
import 'dart:math';

import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:ecarto/Parcial/citacoes.dart';
import 'package:ecarto/Recursos/Api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/prefer_universal/html.dart' as web;

import './Tabs.dart';
import '../Funcoes/UserData.dart';
import '../Funcoes/Utils.dart';
import 'Mapa.dart';

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
  var user;
  bool loading = true;
  String loadQuote = '';

  var myPref = web.window.localStorage['mypref'];

  getQuote() {
    var length = listCitacoes.length;
    var num = Random().nextInt(length);
    setState(() {
      loadQuote = listCitacoes[num];
    });
  }

  getData() async {
    var data = await getHomeData();

    await setProfile(data['user']);

    setState(() {
      user = data['user'];
      materiais = data['materiais'];
      artes = data['artes'];
      loading = false;
    });

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //       loading = false;
    //   });
    // });
  }

  getData2() async {
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

        // var responseArtes = await http.get(
        //     Uri.encodeFull(
        //         host + '/arte?longitude=$long&latitude=$lat&radius=20'),
        //     headers: {"Authorization": token});

        print('url');
        print(host + '/material?longitude=$long&latitude=$lat&radius=20');

        setState(() {
          // this.token = token;
          // this.login = login;
          // this.id = id;
          artes = jsonDecode(responseArtes.body);
          materiais = jsonDecode(responseMateriais.body);
          // loading = false;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            loading = false;
          });
        });
      }).catchError((err) {
        print('erro em jwt');
        print(err);
      });
    }).catchError((err) {
      print('erro em location');
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();

    getQuote();

    if (mounted) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));

    double height = MediaQuery.of(context).size.height;

    if (loading) {
      return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              ),
              Container(height: 20),
              Wrap(
                children: <Widget>[
                  Icon(Icons.format_quote,
                      size: 35, textDirection: TextDirection.rtl),
                  Text(loadQuote,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center)
                ],
              )
            ],
          ));
    }

    if (!kReleaseMode) {
      return Card(
        margin: EdgeInsets.all(0),
          child: DefaultTabController(
              length: 2,
              child: new Scaffold(
                  body: TabBarView(children: [
                    Tabs(user, artes, materiais),
                    Mapa(),
                  ]),
                  bottomNavigationBar: new TabBar(tabs: [
                    Tab(
                        icon: new Column(children: <Widget>[
                      Icon(Icons.home),
                      Text('Inicio')
                    ])),
                    Tab(
                        icon: new Column(
                            children: <Widget>[Icon(Icons.map), Text('Mapa')])),
                  ]))));
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: height,
          delegate: SliverChildListDelegate(
            [
              Tabs(user, artes, materiais),
              // Container(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0)),
            ],
          ),
        ),
      ],
    );
  }
}
