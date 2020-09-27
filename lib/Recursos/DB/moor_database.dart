import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

// class Chat extends Table{
  
// }

class Messages extends Table{
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text()();
  TextColumn get body => text().withLength(min: 1, max: 50)();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get sender => text().withLength(min: 1, max: 50)();
  BoolColumn get read => boolean().withDefault(Constant(false))();
  BoolColumn get send => boolean().withDefault(Constant(false))();
  
  @override
  // ignore: sdk_version_set_literal
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Messages])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'ecartoDB.sqlite',
    logStatements: true
  ));
  
  @override
  int get schemaVersion => 5;

  Future<List<Message>> getAllMessages() => select(messages).get();
  Stream<List<Message>> watchAllMessages() => select(messages).watch();
  Future insertMessage(Message message) => into(messages).insert(message, orReplace: true);

  // TODOO - AVALIAR NECESSIDADE
  // Future updateMessage(Message message) => update(messages).replace(message);
  // Future deleteMessage(Message message) => delete(messages).delete(message);
}