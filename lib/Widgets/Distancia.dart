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
    // print(arte['nature']);
    // print(arte['position']['latitude']);
    // print(arte['longitude']);

    // print(widget.position.latitude);
    // print(widget.position.longitude);

    // var startLat = double.parse(arte['latitude']);
    var startLat = arte['location']['coordinates'][1];
    // var startLong = double.parse(arte['longitude']);
    var startLong = arte['location']['coordinates'][0];

    var endLat = widget.position.latitude;
    var endLong = widget.position.longitude;

    double distanceInMeters = await distanceBetween(startLat, startLong, endLat, endLong);

    print('DISTANCIA');
    print(distanceInMeters);
    print('DISTANCIA');
    return distanceInMeters.floor() / 1000;
  }

  @override
  void initState() {
    super.initState();
    
    setDistancia();  
  }

  setDistancia(){
    if(distancia == '' && widget.position != null ){
      getDistancia(widget.arte).then((d) {
      print('d');
      print(d);
      if (d < 1) {
        setState(() {
          distancia = 'A menos de um kilômetro de distância';
          load = false;
        });
      } else {
        setState(() {
          distancia = 'A ${d.toStringAsFixed(0)} Km daqui';
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

  }

  @override
  Widget build(BuildContext context) {

    if(distancia == '' && widget.position != null ){
      getDistancia(widget.arte).then((d) {
      print('d');
      print(d);
      if (d < 1) {
        setState(() {
          distancia = 'A menos de um kilômetro de distância';
          load = false;
        });
      } else {
        setState(() {
          distancia = 'A ${d.toStringAsFixed(0)} Km daqui';
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

    // return Container();

    if (load) {
      return Container(
        child: Text('Calculando distância...', style: TextStyle(color: Colors.white, fontSize: 10),)
      );
    }

    return Text(distancia, style: TextStyle(color: Colors.white, fontSize: 10));
  }
}
