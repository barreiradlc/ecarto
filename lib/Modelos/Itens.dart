import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbFunctions extends StatefulWidget {
  @override
  DbFunctionsState createState() => DbFunctionsState();
}

class DbFunctionsState extends State<DbFunctions> {
  var database;

  @override
  void initState() {
    super.initState();
    openDB();
  }

  openDB() async {
    // Get a reference to the database.
    var database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'estoque_db.db'),
      // When the database is first created, create a table to store items.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE itens(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, quantidade INTEGER)",
        );
      },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );

    // setState(() {
    //   database = database;
    // });

    return database;
  }

  Future<void> insertItem(Item item, database) async {
    final Database db = await database;
    await db.insert(
      'itens',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(Item item) async {
    // Get a reference to the database.
    final db = await database;



    // Update the given Item.
    await db.update(
      'itens',
      item.toMap(),
      // Ensure that the Item has a matching id.
      where: "id = ?",
      // Pass the Item's id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
  }


Future<Item> item(id,database) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The itens.
    final List<Map<String, dynamic>> item = await db.query('itens WHERE ID = $id');

    return Item(
      name: item[0]['name'], 
      quantidade: item[0]['quantidade'],
      id: item[0]['id'],
    );
  }

  Future<List<Item>> itens(database) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The itens.
    final List<Map<String, dynamic>> maps = await db.query('itens');

    // Convert the List<Map<String, dynamic> into a List<Item>.
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        quantidade: maps[i]['quantidade'],
      );
    });
  }



    Future<void> deleteItem(int id, database) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Item from the database.
    await db.delete(
      'itens',
      // Use a `where` clause to delete a specific item.
      where: "id = ?",
      // Pass the Item's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Item {
  final int id;
  final String name;
  final int quantidade;

  Item({this.id, this.name, this.quantidade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantidade': quantidade,
    };
  }

  // Implement toString to make it easier to see information about
  // each item when using the print statement.
  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantidade: $quantidade}';
  }
}
