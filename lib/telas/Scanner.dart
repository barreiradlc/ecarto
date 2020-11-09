import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode/qrcode.dart';

class Scanner extends StatefulWidget {
  Scanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  QRCaptureController _captureController = QRCaptureController();
  bool _isTorchOn = false;

  scanQRCode(String qrCode){

    print('qrCode');
    print(qrCode);
    if(qrCode.contains("ecartoQR:")){
      String idUser = qrCode.replaceAll("ecartoQR:", "");
      Get.toNamed('/perfil/${idUser}');
    }


    
  }

  @override
  void initState() {
    super.initState();
    _captureController.onCapture((data) {
      print('onCapture----$data');

      scanQRCode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    Widget _buildToolBar() {
      return Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FlatButton(
            //   onPressed: () {
            //     _captureController.pause();
            //   },
            //   child: Text('pause'),
            // ),
            FlatButton(
              onPressed: () {
                if (_isTorchOn) {
                  _captureController.torchMode = CaptureTorchMode.off;
                } else {
                  _captureController.torchMode = CaptureTorchMode.on;
                }
                _isTorchOn = !_isTorchOn;
              },
              child: _isTorchOn ? Icon(Icons.flash_off) : Icon(Icons.flash_on),
            ),
            
            // FlatButton(
            //   onPressed: () {
            //     _captureController.resume();
            //   },
            //   child: Text('resume'),
            // ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,      
        title: Text("Posicione seu código ao centro")  
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRCaptureView(controller: _captureController),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: OpenPainter(),
                // child: QRCaptureView(controller: _captureController),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildToolBar(),
          )
        ],
      ),
    );

  }
}



class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Offset(100, 100) & const Size(200, 200), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
