import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db_test.dart' as db;

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  var estoque;
  String label;

  bool form = true;

  var nome = TextEditingController(text: '');
  var idade = TextEditingController(text: '1');
  var id = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    list();
  }

  void formDialogModal(dog, status) async {
    print(dog);
    print(status);
    print(status);
    print(status);

    setState(() {
      nome.text = status == 'edit' ? dog.name : '';
      idade.text = status == 'edit' ? dog.age.toString() : '';
      id.text = status == 'edit' ? dog.id.toString() : '';
      label = status == 'edit' ? 'Editar' : 'Adicionar';
    });

    return showDialog(
      context: context,
      builder: (context) {
        return Container(
            height: 60,
            child: AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              backgroundColor: Colors.white,
              content: Form(
                  // backgroundColor: Colors.white,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: nome,
                      // obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                        labelText: 'Nome',
                      ),
                      autofocus: true,
                    )),
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: idade,
                      // obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                        labelText: 'Quantidade',
                      ),
                      // autofocus: true,
                    )),

                // alignment: Alignment(1.0, 1.0),
                RaisedButton(
                    color: Colors.green,
                    padding: EdgeInsets.all(5),
                    onPressed: add,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          Text(label, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ))
              ])),
            ));
      },
    );
  }

  void formDialog(id) async {
    print(id);
    await db.DbFunctionsState().openDB().then((d) {
      db.DbFunctionsState().dog(id, d).then((dog) {
        formDialogModal(dog, 'edit');
      });
    });
  }

  void remove(index) async {
    print(index);
    db.DbFunctionsState().openDB().then((d) {
      db.DbFunctionsState().deleteDog(index.id, d);
    });
    list();
  }

  add() async {
    if (id.text == null) {
      print("NOVO ITEM");
    }

    print(id.text);

    var dog = db.Dog(
        // id: id.text != '' ? int.parse(id.text) : 0,
        age: int.parse(idade.text),
        name: nome.text);

    db.DbFunctionsState().openDB().then((d) {
      db.DbFunctionsState()
          .insertDog(dog, d, id.text != '' ? int.parse(id.text) : null)
          .then((v) {
        list();
        Navigator.pop(context, v);
      });
    });
  }

  list() async {
    print('list');
    await db.DbFunctionsState().openDB().then((d) {
      db.DbFunctionsState().dogs(d).then((estoque) {
        print('estoque');
        print(estoque);
        setState(() {
          this.estoque = estoque;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (estoque != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Estoque'),
        ),
        // body: Center(
        body: Container(
            child: Stack(children: <Widget>[
          ListView.builder(
              itemCount: this.estoque == null ? 0 : this.estoque.length,
              itemBuilder: (BuildContext context, int index) {
                print('index');
                print('index');
                print('index');
                print(index);
                return Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: RaisedButton(
                        color: Colors.white,
                        onPressed: () => formDialog(this.estoque[index].id),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(this.estoque[index].name),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      this.estoque[index].age.toString() +
                                          " Disponíveis",
                                      style: TextStyle(color: Colors.green)
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(2),
                                      icon: Icon(Icons.delete),
                                      onPressed: () =>
                                          remove(this.estoque[index]),
                                    ),
                                  ],
                                )
                              ],
                            )
                            // child: ,
                            )));
              }),
        ])),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onPressed: () => formDialogModal(null, 'new'),
          tooltip: 'Show me the value!',
          child: Icon(Icons.add),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
      //   ),
      // );
    }
    return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue,)
          )
        )
    );
  }
}
