import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_carto/Construtores/StepsConstructor.dart';
import 'package:e_carto/telas/Passo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Etapas extends StatefulWidget {
  // final steps;
  // Etapas(this.steps);

  @override
  EtapaState createState() => new EtapaState();
}

class EtapaState extends State<Etapas> {
  File _image;
  String uri = 'https://ae-teste.herokuapp.com';
  
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }



  Widget build(BuildContext context) {
      final StepsArguments item = ModalRoute.of(context).settings.arguments;

      print('------');
      print('------');
      print(item.title);
      print(item.steps.length);
      print('------');
      print('------');

      var etapas = item.steps.length != 0 ? CarouselSlider(
      height: double.infinity,
      
      // aspectRatio: 16 / 9,
      // viewportFraction: 0.8,
      // initialPage: 0,
      enableInfiniteScroll: false,
      // reverse: false,
      autoPlay: false,
      // autoPlayInterval: Duration(seconds: 3),
      // autoPlayAnimationDuration: Duration(milliseconds: 800),
      //  autoPlayCurve: Curve.fastOutSlowIn,
      // pauseAutoPlayOnTouch: Duration(seconds: 10),
      enlargeCenterPage: true,
      //  onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,

      items: item.steps.map((i, index) {

        return Builder(
          builder: (BuildContext context) {
              return Passo(i[index], 'editar');
          },
        );
        
      }).toList(),

    ) : Passo(item.id, 'criar');

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Passo"),
      ),
      body: Column(
        children: <Widget>[
          etapas,
        ],
      )
    );

  }



}
