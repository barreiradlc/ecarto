import 'dart:async';

import 'package:ecarto/Funcoes/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
  List<Marker> artesMarker;

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

  getMarkers() {
    for (var i = 0; i < widget.artes.length; i++) {
      artesMarker.add(Marker(
          width: 80.0,
          height: 80.0,
          point: new LatLng(widget.artes[i]['location']['coordinates'][1],
              widget.artes[i]['location']['coordinates'][0]),
          builder: (ctx) => new Container(
                  child: Row(
                children: [
                  Text(widget.artes[i]['title']),
                  Icon(Icons.brush),
                ],
              ))));
    }
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
        appBar: AppBar(
          title: Text('Localização', style: TextStyle(color: Colors.white)),
        ),
        body: FlutterMap(
          options: new MapOptions(
            center: new LatLng(location.latitude, location.longitude),
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
                // urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmFycmVpcmFkbGMiLCJhIjoiY2tnNzY1d3VkMDQ5azJ4bXU2Y3R2YWd5eSJ9.f5nb58yAnNBmPQhHwxV98g",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: [
                // artesMarker

                Marker(
                    width: 280.0,
                    height: 80.0,
                    point: new LatLng(
                        widget.artes[0]['location']['coordinates'][1],
                        widget.artes[0]['location']['coordinates'][0]),
                    builder: (ctx) => new Container(
                            child: Row(
                          children: [
                            Text(widget.artes[0]['title']),
                            Icon(Icons.brush),
                          ],
                        )))

                // new Marker(
                //   width: 80.0,
                //   height: 80.0,
                //   point: new LatLng(51.5, -0.09),
                //   builder: (ctx) => new Container(
                //     child: new FlutterLogo(),
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }
}
