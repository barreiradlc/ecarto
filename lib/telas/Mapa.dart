import 'dart:async';

import 'package:ecarto/Construtores/ItemsConstructor.dart';
import 'package:ecarto/Funcoes/Utils.dart';
import 'package:ecarto/Widgets/Distancia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class Mapa extends StatefulWidget {
  final user;
  final artes;
  final materiais;

  Mapa(this.user, this.artes, this.materiais);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  var location;
  List<Marker> markers = <Marker>[];
  List<Marker> artesMarker = <Marker>[];
  List<Marker> materiaisMarker = <Marker>[];

  var showArtes = true;
  var showMateriais = true;

  @override
  void initState() {
    getInitialData();

    super.initState();
  }

  getInitialData() async {
    var locationData = await getLocation();

    print("location");
    print(location);

    setState(() {
      location = locationData;
    });

    getMarkers();
  }



  List <Marker> getMateriaisMarkers() {
    List <Marker> materiaisMarkers = <Marker>[];

    for (var i = 0; i < widget.materiais.length; i++) {
      materiaisMarkers.add(new Marker(
          width: 120.0,
          height: 120.0,
          point: new LatLng(widget.materiais[i]['location']['coordinates'][1],
              widget.artes[i]['location']['coordinates'][0]),
          builder: (ctx) => markerContainer(widget.materiais[i], i)));
    }

    return materiaisMarkers;
  }

  List <Marker> getArtesMarkers() {
    List <Marker> artesMarkers = <Marker>[];

    for (var i = 0; i < widget.artes.length; i++) {
      artesMarkers.add(new Marker(
          width: 80.0,
          height: 80.0,
          point: new LatLng(widget.artes[i]['location']['coordinates'][1],
              widget.artes[i]['location']['coordinates'][0]),
          builder: (ctx) => markerContainer(widget.artes[i], i)));
    }

    return  artesMarkers;
  }

  getMarkers() {
      toggleMarkersFilter("ALL");
  }

  toggleMarkersFilter(String type){

    switch (type) {
      case "ARTE":
        setState(() {
          showArtes = !showArtes;
        });
        break;
      case "MATERIAL":
        setState(() {
          showMateriais = !showMateriais;

        });
        break;
      default:
        print("ALL");
    }

    
    Future.delayed(const Duration(milliseconds: 5), () {
      List <Marker> localMarkers = <Marker>[];

      print("active");
      print(showArtes);
      print(showMateriais);

      if(showArtes) {
        List <Marker> artesMarkers = getArtesMarkers();
        localMarkers.addAll(artesMarkers);
      }
      if(showMateriais) {
        List <Marker> materiaisMarkers = getMateriaisMarkers();
        localMarkers.addAll(materiaisMarkers);
      }

      setState(() {
        markers = localMarkers;
      });
    });

  }

  void _goToSingle(dynamic item, index) {
    Navigator.pushNamed(
      context,
      '/item',
      arguments: ScreenArguments(
        item['title'],
        item['description'],
        item['image'],
        DateTime.parse(item['updated_at']),
        item['nature'],
        item['user']['_id'],
        item['_id'],
        item['price'],
        index,
      ),
    );
  }

  void _configurandoModalBottomSheet(dynamic item, index) {
    Get.bottomSheet(Card(
      color: Colors.white,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => _goToSingle(item, index),
          child: Stack(alignment: Alignment.bottomLeft,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                          alignment: Alignment.center,
                          child: item['image'] != null || item['image'] != ''
                              ? Image.network(item['image'], fit: BoxFit.cover)
                              : Image.asset("assets/logo.png")),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: [
                      ListTile(
                          tileColor: Colors.black87.withOpacity(0.3),
                          // leading: new Icon(Icons.music_note),
                          title: new Distancia(item, location),
                          onTap: () => {}),
                      ListTile(
                        tileColor: Colors.white.withOpacity(1),
                        // leading: new Icon(Icons.music_note),
                        title: new Text(item['title'],
                            style: TextStyle(color: Colors.black87)),
                      ),
                      ListTile(
                          tileColor: Colors.white.withOpacity(1),
                          // leading: new Icon(Icons.music_note),
                          title: new Text(item['description'],
                              style: TextStyle(color: Colors.black87)),
                          onTap: () => {}),
                      ListTile(
                          tileColor: Colors.white.withOpacity(1),
                          // leading: new Icon(Icons.music_note),
                          title: new Text("R\$:${item['price'].toString()}",
                              style: TextStyle(color: Colors.black87)),
                          onTap: () => {}),
                    ],
                  ),
                )
              ])),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return Scaffold(
          body: Center(
        heightFactor: 80,
        widthFactor: 80,
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(40, 100),
          child: AppBar(
            title: Text('${markers.length} ite${markers.length != 1 ? 'ns' : 'm'} ao seu alcance',
                style: TextStyle(color: Colors.white)),
            bottom: PreferredSize(
              preferredSize: const Size(20, 90),
              child: Row(
                children: [
                  FlatButton(
                    onPressed: () => toggleMarkersFilter("MATERIAL"),
                    child: Chip(
                      backgroundColor: showMateriais ? Colors.white : Colors.black12,
                      avatar: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0),
                          child:
                              Icon(Icons.extension, color: showMateriais ? Color(0xff558b2f) : Colors.black38)),
                      label: Text('Materiais', style: TextStyle(fontWeight: showMateriais ? FontWeight.bold : FontWeight.normal)),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => toggleMarkersFilter("ARTE"),
                    child: Chip(
                      backgroundColor: showArtes ?  Colors.white : Colors.black12,
                      avatar: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0),
                          child:
                              Icon(Icons.brush, color: showArtes ? Color(0xff42A5F5) : Colors.black38)),
                      label: Text('Artes', style: TextStyle(fontWeight: showArtes ? FontWeight.bold : FontWeight.normal)),
                    ),
                  ),                  
                ],
              ),
            ),
          ),
        ),
        body: FlutterMap(
          options: new MapOptions(
            center: new LatLng(location.latitude, location.longitude),
            zoom: 15.0,
          ),
          layers: [
            new TileLayerOptions(
                // urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmFycmVpcmFkbGMiLCJhIjoiY2tnNzY1d3VkMDQ5azJ4bXU2Y3R2YWd5eSJ9.f5nb58yAnNBmPQhHwxV98g",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(markers: markers
                // for (var i = 0; i < artesMarker.length; i++) {

                // Marker(
                //     width: 280.0,
                //     height: 80.0,
                //     point: new LatLng(
                //         widget.artes[i]['location']['coordinates'][1],
                //         widget.artes[i]['location']['coordinates'][0]),
                //     builder: (ctx) => new Container(
                //             child: Row(
                //           children: [
                //             Text(widget.artes[i]['title']),
                //             Icon(Icons.brush),
                //           ],
                //         )))

                // }

                // Marker(
                //     width: 280.0,
                //     height: 80.0,
                //     point: new LatLng(
                //         widget.artes[0]['location']['coordinates'][1],
                //         widget.artes[0]['location']['coordinates'][0]),
                //     builder: (ctx) => new Container(
                //             child: Row(
                //           children: [
                //             Text(widget.artes[0]['title']),
                //             Icon(Icons.brush),
                //           ],
                //         )))

                // new Marker(
                //   width: 80.0,
                //   height: 80.0,
                //   point: new LatLng(51.5, -0.09),
                //   builder: (ctx) => new Container(
                //     child: new FlutterLogo(),
                //   ),
                // ),

                ),
          ],
        ));
  }

  FlatButton markerContainer(item, index) {
    var icon;
    var color;

    if (item['nature'] == "MATERIAL") {
      icon = Icons.extension;
      color = Color(0xff558b2f);
    } else if (item['nature'] == "ARTE") {
      icon = Icons.brush;
      color = Color(0xff42A5F5);
    }

    return FlatButton(
        onPressed: () => _configurandoModalBottomSheet(item, index),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Icon(icon, size: 30, color: color),
        ));
  }
}
