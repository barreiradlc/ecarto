import 'package:e_carto/db_test.dart';

class Todo{
    int id;
    String name;
    String info;
    bool deleted;

    Todo(
        this.id,
        this.name,
        this.info,
        this.deleted,
    );

    Todo.fromJson(Map<String, dynamic> json) {
        this.id = json[DatabaseCreator.id];
        this.name = json[DatabaseCreator.name];
        this.info = json[DatabaseCreator.info];
        this.deleted = json[DatabaseCreator.deleted] == 1;
    }
}