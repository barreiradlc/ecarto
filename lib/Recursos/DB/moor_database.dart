import 'package:ecarto/telas/Chat.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Messages extends Table{
  TextColumn get id => text()();
  TextColumn get chatId => text()();
  TextColumn get body => text().withLength(min: 1)();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get sender => text().withLength(min: 1, max: 50)();
  BoolColumn get read => boolean().withDefault(Constant(false))();
  BoolColumn get send => boolean().withDefault(Constant(false))();
  
  @override
  // ignore: sdk_version_set_literal
  Set<Column> get primaryKey => {id};
}

class Chats extends Table{  
  TextColumn get id => text()();  
  TextColumn get de => text()();
  TextColumn get photofrom => text()();  
  
  @override
  // ignore: sdk_version_set_literal
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Messages, Chats])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'ecartoDB.sqlite',
    logStatements: true
  ));
  
  @override
  int get schemaVersion => 9;

  Future<List<Message>> getAllMessages() => select(messages).get();
  Stream<List<Message>> watchAllMessages() => select(messages).watch();
  Future insertMessage(Message message) => into(messages).insert(message, orReplace: true);

  Future<List<Chat>> getAllChats() => select(chats).get();
  Stream<List<Chat>> watchAllChats() => select(chats).watch();
  Future insertChat(Chat chat) => into(chats).insert(chat, orReplace: true);

  // TODOO - AVALIAR NECESSIDADE
  // Future updateMessage(Message message) => update(messages).replace(message);
  // Future deleteMessage(Message message) => delete(messages).delete(message);
}