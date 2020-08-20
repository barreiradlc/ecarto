import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;

dialogoAlerta(String msg, context,{ bool loading = true}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      msg,
                    )
                  ],
                )));
      },
    );
  }
  
  // multiplas mensagens
  dialogoAlertaLista(List<String> msgs, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // Retrieve the text the that user has entered by using the
            content: Container(
                padding: EdgeInsetsDirectional.only(top: 50),
                height: 150,
                child: 
                  Column(children: msgs.map((item) => new Text(item)).toList())
                 ));
      },
    );
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }

  compressImage(image) async{
    final dir = await path_provider.getTemporaryDirectory();
    File file = createFile("${dir.absolute.path}/a${path.basename(image.path)}");
    Uint8List bytes = image.readAsBytesSync();
    file.writeAsBytes(bytes);

    return await testCompressAndGetFile(image, file.path);
  }

  Future testCompressAndGetFile(File file, String targetPath) async {    

    var quality = file.lengthSync() / 100000;
    int qualityInt = quality.round();

    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: qualityInt == 0 || qualityInt == 1 ? 20 : qualityInt,
        // inSampleSize: 2
        // rotate: 180,
      );

    print("FILE");
    print('ORIGINAL -> ${file.lengthSync()}');
    print('CONVERTED -> ${result.lengthSync()}');

    print("FILE = ${qualityInt}");

    if(qualityInt < 5){
      return file;
    }

    if(result.lengthSync() > 25000){
      print('COMPRIMIR');
      return compressImage(result);
      // return result;
    } else {
      print('NÂO COMPRIMIR');
      return file;
    }
    
  }