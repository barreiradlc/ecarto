import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselList extends StatefulWidget {
  final steps;
  CarouselList(this.steps);

  @override
  CarouselLisState createState() => new CarouselLisState();
}

class CarouselLisState extends State<CarouselList> {
  String uri = 'https://ae-teste.herokuapp.com';

 

  
  Widget build(BuildContext context) {
    // print(widget.steps);
    // return CarouselSlider(
    //     height: double.infinity - 200,
    //     enableInfiniteScroll: false,
    //     items: [1,2,3,4,5].map((i) {
    //       return Builder(
    //         builder: (BuildContext context) {
    //           return Container(
    //             width: MediaQuery.of(context).size.width,
    //             margin: EdgeInsets.symmetric(horizontal: 5.0),
    //             decoration: BoxDecoration(
    //               color: Colors.amber
    //             ),
    //             child: Text('text $i', style: TextStyle(fontSize: 16.0),)
    //           );
    //         },
    //       );
    //     }).toList(),
    //   );
      

      return CarouselSlider(
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

      items: widget.steps.map<Widget>((i) {
        var bg;
        bg = AssetImage("assets/logo.png");
        if (i['avatar']['url'] != null) {
          bg = NetworkImage(uri + i['avatar']['url']);
        }
        return Builder(
          builder: (BuildContext context) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: bg,
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Text(
                            // 'text $i',
                            i['title'],
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Text(
                            // 'text $i',
                            i['description'],
                            style: TextStyle(fontSize: 16.0),
                          ))
                    ]));
          },
        );
      }).toList(),

    );
    


  }



}
