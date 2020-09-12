import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  var barcode;
  String id;

  @override
  initState() {
    super.initState();

    scan();
  }

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      goToProfile();
    }

    return Card(child: Center( heightFactor: 40, widthFactor: 40, child: CircularProgressIndicator()));
  }

  goToProfile() {
    Get.toNamed('/perfil/$id');    
    setState(() {
      id = '';
    });
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      if(barcode.rawContent != ''){
        setState(() => id = barcode.rawContent);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
