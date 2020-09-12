import 'package:flutter/widgets.dart';

class ItensWidget extends StatefulWidget {
  
  final profile;

  ItensWidget(this.profile);

  @override
  _ItensWidgetState createState() => _ItensWidgetState();
}

class _ItensWidgetState extends State<ItensWidget> {


  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    return Container();

    return Container(
       child: Text("Alou"),
    );
  }
}