import 'dart:convert';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:ecarto/Construtores/UserArguments.dart';
import 'package:ecarto/Funcoes/UserPreferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ecarto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/qrcode.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Home/Wikis.dart';
import './Home/Materiais.dart';
import './Home/Artes.dart';

import '../Funcoes/UserData.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

// List<RScanCameraDescription> rScanCameras;

class Tabs extends StatefulWidget {
  var tema = 0;

  final user;
  final artes;
  final materiais;

  Tabs(this.user, this.artes, this.materiais);

  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  QRCaptureController _captureController = QRCaptureController();
  bool _isTorchOn = false;

  final List<Tab> myTabs = <Tab>[
    Tab(
        icon: Icon(Icons.brush),
        child: Text(
          'Artes',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
    Tab(
        icon: Icon(Icons.extension),
        child: Text(
          'Materiais',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
  ];

  TabController _tabController;

  bool _activeTabIndex = true;
  bool loading = true;
  var bg;
  String id;
  String error;
  var materiais;
  var artes;
  String username = '';

  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = _tabController.index == 0 ? true : false;
    });
  }

  goToProfile() async {
    String userId = await void_getID();
    Get.toNamed('/perfil/${userId}');
  }

  handleLogout() async {
    removeLoginData().then((response) {
      print('LOGOUT');
      print(response);
      print('LOGOUT');

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  // _scan() async {
  //   // String barcode2 = await scanner.scanPhoto();
  //   // String barcode = await scanner.scan();

  //   // print(barcode);
  //   // print(barcode2);
  //   // String barcode = await scanner.scanPath(path);

  // }

  _scan() async {
    Get.toNamed('/scan');
    //  final content = await QrUtils.scanQR;

    //
  }

  _scan2() async {
    // return;

    // var options = ScanOptions(
    //   strings: {
    //     "cancel": "Cancelar",
    //     "flash_on": "Habilitar flash",
    //     "flash_off": "Desabilitar flash",
    //   },
    // );

    // // return Get.toNamed('/perfil/5f4067fab504e91ce49ca9e9');

    // try {
    //   var barcode = await BarcodeScanner.scan(options: options);
    //   if (barcode.rawContent.contains("ecartoQR:")) {
    //     String qrCode = barcode.rawContent.replaceAll("ecartoQR:", "");
    //     // setState(() => id = barcode.rawContent);
    //     Get.toNamed('/perfil/${qrCode}');
    //     // Navigator.pushNamed(context, '/perfil', arguments: barcode.rawContent);
    //   } else {
    //     if (barcode.rawContent != '') {
    //       _scan();
    //     }
    //   }
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.cameraAccessDenied) {
    //     setState(() {
    //       error = 'The user dids not grant the camera permission!';
    //     });
    //   } else {
    //     setState(() => error = 'Unknown error: $e');
    //   }
    // } on FormatException {
    //   setState(() => error =
    //       'null (User returned using the "back"-button before scanning anything. Result)');
    // } catch (e) {
    //   setState(() => error = 'Unknown error: $e');
    // }
  }

  @override
  void initState() {
    super.initState();
    _captureController.onCapture((data) {
      print('onCapture----$data');
    });

    _tabController = TabController(vsync: this, length: myTabs.length);
    if (mounted) {
      if (widget.user['image'] != null && widget.user['image'] != "") {
        setState(() {
          bg = NetworkImage(widget.user['image']);
        });
      } else {
        setState(() {
          bg = AssetImage("assets/logo-white.png");
        });
      }

      setState(() {
        loading = false;
      });
      print('widget.materiais');
      print(widget.artes);
      print(widget.materiais);
      print('widget.materiais');
      // await getData();
      _tabController.addListener(_setActiveTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var drawerScaff = Drawer(
      elevation: 3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Bem Vindo(a) ${widget.user['name'] != null ? widget.user['name'] : ''}",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: bg,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.65), BlendMode.dstOut),
              ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              goToProfile();

              // Navigator.pushNamed(context, '/perfil', arguments: UserArguments(
              //   widget.user['id'],
              //   widget.user['name'],
              //   widget.user['username'],
              //   widget.user['email'],
              //   widget.user['phone'],
              //   widget.user['instagram'],
              //   widget.user['pinterest'],
              //   widget.user['about'],
              //   widget.user['image'],
              // ));
            },
          ),
          ListTile(
            title: Text('Estoque'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/estoque');
            },
          ),
          ListTile(
            title: Text('Chat'),
            onTap: () {
              const chatId = '';
              Navigator.pop(context);
              Get.toNamed('/chat');
            },
          ),
          Divider(height: 25),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Card(
                          child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              child: Text("Deseja realmente sair?"),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Não")),
                                  FlatButton(
                                      onPressed: handleLogout,
                                      child: Text("Sim"))
                                ])
                          ],
                        ),
                      )),
                    );
                  });
            },
          )
        ],
      ),
    );

    if (loading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
      ));
    }

    // if (id != null) {
    //   goToProfile(context);
    // }

    // child: _buildToolBar(),
    // child: _buildToolBar(),

    return Theme(
        data: ThemeData(
            accentColor: Colors.black,
            primaryColor: _activeTabIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor),
        child: Scaffold(
          drawer: drawerScaff,
          appBar: AppBar(
            actions: [
              FlatButton(
                  onPressed: _scan,
                  child: Icon(Icons.center_focus_weak, color: Colors.white))
            ],
            brightness: Brightness.dark, // status bar brightness
            iconTheme: new IconThemeData(color: Colors.white),
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            // When the user presses the button, show an alert dialog containing
            // the text that the user has entered into the text field.
            foregroundColor: Colors.white,
            backgroundColor: _activeTabIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            onPressed: () {
              Navigator.pushNamed(context, '/itens/form',
                  arguments: _activeTabIndex ? "arte" : "material");
            },
            tooltip: _activeTabIndex ? "Criar Arte" : "Criar Material",
            child: Icon(Icons.add),
          ),
          body: TabBarView(
            controller: _tabController,
            // children: myTabs.map((Tab tab) {
            //   final String label = tab.text.toLowerCase();
            //   return Center(
            //     child: Text(
            //       'This is the $label tab',
            //       style: const TextStyle(fontSize: 36),
            //     ),
            //   );
            // }).toList(),
            children: [
              // Wikis(),
              // ArtesMap(widget.artes),
              Artes(widget.artes),
              Materiais(widget.materiais),
            ],
          ),
        ));

    // return Theme(
    //     data: ThemeData(primaryColor: _activeTabIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).accentColor),
    //     child: DefaultTabController(
    //         length: 2,
    //         child: Scaffold(
    //           drawer: drawerScaff,
    //           appBar: AppBar(
    //             bottom: tabs(),
    //             // automaticallyImplyLeading: false,
    //             // title: RaisedButton(onPressed: () => { drawerScaff.build(context) }),
    //           ),
    //           body: TabBarView(
    //             children: [
    //               // Wikis(),
    //               Artes(widget.artes),
    //               Materiais(widget.materiais),
    //             ],
    //           ),
    //         )));
  }
}

Widget tabs() {
  return TabBar(
    indicatorColor: Colors.green,
    onTap: (index) => {print('pokebola vai $index')},
    tabs: [
      // Tab(icon: Icon(Icons.collections_bookmark), child: Text('Wikis')),
      Tab(icon: Icon(Icons.brush), child: Text('Artes')),
      Tab(icon: Icon(Icons.extension), child: Text('Materiais')),
    ],
  );
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
