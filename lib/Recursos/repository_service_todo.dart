import 'package:e_carto/Modelos/Todo.dart';
import 'package:e_carto/db_test.dart';

class RepositoryServiceTodo {
  // listar todos
  static Future<List<Todo>> getAllTodos() async {
    final sql = '''SELECT * FROM${DatabaseCreator.todoTable}
        WHERE ${DatabaseCreator.deleted} == 0''';
    final data = await db.rawQuery(sql);
    List<Todo> todos = List();

    for (final node in data) {
      final todo = Todo.fromJson(node);
      todos.add(todo);
    }
    return todos;
  }

  // buscar
  static Future<Todo> getTodo(int id) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}
      WHERE ${DatabaseCreator.id} == $id''';
    final data = await db.rawQuery(sql);
    final todo = Todo.fromJson(data[0]);
    return todo;
  }

  // adicionar
  static Future<void> addTodo(Todo todo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.todoTable}(
        ${DatabaseCreator.id},
        ${DatabaseCreator.name},
        ${DatabaseCreator.info},
        ${DatabaseCreator.deleted}
      )
      VALUES
      (
        ${todo.id},
        "${todo.name}",
        "${todo.info}",
        ${todo.deleted ? 1 : 0}
      )''';

      final result = await db.rawInsert(sql);
      DatabaseCreator.databaseLog('add', sql, null, result);
  }

  // remove
  static Future<void> deleteTodo(Todo todo) async{
    final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.deleted} = 1
    WHERE ${DatabaseCreator.id} == ${todo.id}
    ''';

    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog('delete', sql, null, result);

  }

  // update
  static Future<void> updateTodo(Todo todo) async{
    final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.name} = "${todo.name}
    WHERE ${DatabaseCreator.todoTable} == ${todo.id}''';

    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog('update', sql, null, result);

  }

  // count
  static Future<int> countTodos() async{
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.todoTable}''');

    int count = data[0].values.elementAt(0);
    return count;
  }

}
