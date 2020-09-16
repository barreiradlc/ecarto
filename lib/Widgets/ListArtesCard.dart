import 'package:flutter/material.dart';

import 'ArteCard.dart';

class ListArtesCard extends StatefulWidget {
  
  final artes;  

  ListArtesCard(this.artes);

  @override
  _ListArtesCardState createState() => _ListArtesCardState();
}

class _ListArtesCardState extends State<ListArtesCard> {
  @override
  Widget build(BuildContext context) {

    var artes = widget.artes;

    return Container(
       child: Container(            
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),            
            height: 200,
            width: MediaQuery.of(context).size.width ,
            child: GridView.count(
            
            padding: EdgeInsets.only(top: 15),
            scrollDirection: Axis.horizontal,                        

            crossAxisCount: 1,
            children: List.generate(artes.length, (index) {          
              return ArteCard(artes[index]);

              // var bg;

              // if (artes[index]['image'] != null) {           
              //   if (artes[index]['image'] == null) {
              //     bg = AssetImage("assets/logo.png");
              //   } else {
              //     bg = NetworkImage(artes[index]['image']);
              //   }
              // } else {
              //   bg = AssetImage("assets/logo.png");
              // }                                          

              // // ITEM
              // return Container(
              //   alignment: Alignment.centerLeft,
              //   decoration: BoxDecoration(                  
              //     image: DecorationImage(
              //       image: bg,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   child: Text('Algo2'),
              // );


            }))
           ),
    );
  }
}