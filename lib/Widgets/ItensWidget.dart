import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ListArtesCard.dart';

class ItensWidget extends StatefulWidget {
  
  final profile;

  ItensWidget(this.profile);

  @override
  _ItensWidgetState createState() => _ItensWidgetState();
}

class _ItensWidgetState extends State<ItensWidget> {


  @override
  Widget build(BuildContext context) {
    final artes = widget.profile['artes'];

    if(artes.length == 0){
      return Container();
    }

    return Container(
        padding: EdgeInsets.only(left: 25),
        child: Column(         
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Text('Artes', style: TextStyle( color: Colors.white, fontSize: 23 ),),
           ListArtesCard(artes),
         ],
       )
    );
  }
}