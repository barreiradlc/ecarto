import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Distancia extends StatefulWidget {
  final arte;
  final position;

  Distancia(this.arte, this.position);

  @override
  _DistanciaState createState() => _DistanciaState();
}

class _DistanciaState extends State<Distancia> {
  var distancia = '';
  bool load = true;

  getDistancia(arte) async {
    print('arte');
    print(arte['latitude']);
    print(arte['longitude']);

    print(widget.position.latitude);
    print(widget.position.longitude);

    var startLat = double.parse(arte['latitude']);
    var startLong = double.parse(arte['longitude']);

    var endLat = widget.position.latitude;
    var endLong = widget.position.longitude;

    double distanceInMeters = await Geolocator()
        .distanceBetween(startLat, startLong, endLat, endLong);

    print('DISTANCIA');
    print(distanceInMeters);
    print('DISTANCIA');
    return distanceInMeters.toInt();
  }

  @override
  void initState() {
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {

    if(distancia == '' && widget.position != null ){
      getDistancia(widget.arte).then((d) {
      print('d');
      print(d);
      if (d == 0) {
        setState(() {
          distancia = 'A menos de um kilômetro de distância';
          load = false;
        });
      } else {
        setState(() {
          distancia = 'A $d Km daqui';
          load = false;
        });
      }
      print(distancia);
      print('dist');
    }).catchError((e) {
      print(e);
    });

    print('distancia');
    print(distancia == '');
    }

    if (load) {
      return Container(
        child: Text('Calculando distância...'),
      );
    }

    return Text(distancia);
  }
}