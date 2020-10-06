// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String chatId;
  final String body;
  final DateTime createdAt;
  final String sender;
  final bool read;
  final bool send;
  Message(
      {@required this.id,
      @required this.chatId,
      @required this.body,
      this.createdAt,
      @required this.sender,
      @required this.read,
      @required this.send});
  factory Message.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Message(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      chatId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}chat_id']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      sender:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}sender']),
      read: boolType.mapFromDatabaseResponse(data['${effectivePrefix}read']),
      send: boolType.mapFromDatabaseResponse(data['${effectivePrefix}send']),
    );
  }
  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Message(
      id: serializer.fromJson<String>(json['id']),
      chatId: serializer.fromJson<String>(json['chatId']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sender: serializer.fromJson<String>(json['sender']),
      read: serializer.fromJson<bool>(json['read']),
      send: serializer.fromJson<bool>(json['send']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'chatId': serializer.toJson<String>(chatId),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sender': serializer.toJson<String>(sender),
      'read': serializer.toJson<bool>(read),
      'send': serializer.toJson<bool>(send),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Message>>(bool nullToAbsent) {
    return MessagesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      chatId:
          chatId == null && nullToAbsent ? const Value.absent() : Value(chatId),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      sender:
          sender == null && nullToAbsent ? const Value.absent() : Value(sender),
      read: read == null && nullToAbsent ? const Value.absent() : Value(read),
      send: send == null && nullToAbsent ? const Value.absent() : Value(send),
    ) as T;
  }

  Message copyWith(
          {String id,
          String chatId,
          String body,
          DateTime createdAt,
          String sender,
          bool read,
          bool send}) =>
      Message(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        sender: sender ?? this.sender,
        read: read ?? this.read,
        send: send ?? this.send,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('sender: $sender, ')
          ..write('read: $read, ')
          ..write('send: $send')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          chatId.hashCode,
          $mrjc(
              body.hashCode,
              $mrjc(
                  createdAt.hashCode,
                  $mrjc(sender.hashCode,
                      $mrjc(read.hashCode, send.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == id &&
          other.chatId == chatId &&
          other.body == body &&
          other.createdAt == createdAt &&
          other.sender == sender &&
          other.read == read &&
          other.send == send);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> chatId;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String> sender;
  final Value<bool> read;
  final Value<bool> send;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sender = const Value.absent(),
    this.read = const Value.absent(),
    this.send = const Value.absent(),
  });
  MessagesCompanion copyWith(
      {Value<String> id,
      Value<String> chatId,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<String> sender,
      Value<bool> read,
      Value<bool> send}) {
    return MessagesCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      sender: sender ?? this.sender,
      read: read ?? this.read,
      send: send ?? this.send,
    );
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  final GeneratedDatabase _db;
  final String _alias;
  $MessagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  GeneratedTextColumn _chatId;
  @override
  GeneratedTextColumn get chatId => _chatId ??= _constructChatId();
  GeneratedTextColumn _constructChatId() {
    return GeneratedTextColumn(
      'chat_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn('body', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _senderMeta = const VerificationMeta('sender');
  GeneratedTextColumn _sender;
  @override
  GeneratedTextColumn get sender => _sender ??= _constructSender();
  GeneratedTextColumn _constructSender() {
    return GeneratedTextColumn('sender', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _readMeta = const VerificationMeta('read');
  GeneratedBoolColumn _read;
  @override
  GeneratedBoolColumn get read => _read ??= _constructRead();
  GeneratedBoolColumn _constructRead() {
    return GeneratedBoolColumn('read', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _sendMeta = const VerificationMeta('send');
  GeneratedBoolColumn _send;
  @override
  GeneratedBoolColumn get send => _send ??= _constructSend();
  GeneratedBoolColumn _constructSend() {
    return GeneratedBoolColumn('send', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, chatId, body, createdAt, sender, read, send];
  @override
  $MessagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'messages';
  @override
  final String actualTableName = 'messages';
  @override
  VerificationContext validateIntegrity(MessagesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.chatId.present) {
      context.handle(
          _chatIdMeta, chatId.isAcceptableValue(d.chatId.value, _chatIdMeta));
    } else if (chatId.isRequired && isInserting) {
      context.missing(_chatIdMeta);
    }
    if (d.body.present) {
      context.handle(
          _bodyMeta, body.isAcceptableValue(d.body.value, _bodyMeta));
    } else if (body.isRequired && isInserting) {
      context.missing(_bodyMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.sender.present) {
      context.handle(
          _senderMeta, sender.isAcceptableValue(d.sender.value, _senderMeta));
    } else if (sender.isRequired && isInserting) {
      context.missing(_senderMeta);
    }
    if (d.read.present) {
      context.handle(
          _readMeta, read.isAcceptableValue(d.read.value, _readMeta));
    } else if (read.isRequired && isInserting) {
      context.missing(_readMeta);
    }
    if (d.send.present) {
      context.handle(
          _sendMeta, send.isAcceptableValue(d.send.value, _sendMeta));
    } else if (send.isRequired && isInserting) {
      context.missing(_sendMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Message.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MessagesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.chatId.present) {
      map['chat_id'] = Variable<String, StringType>(d.chatId.value);
    }
    if (d.body.present) {
      map['body'] = Variable<String, StringType>(d.body.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.sender.present) {
      map['sender'] = Variable<String, StringType>(d.sender.value);
    }
    if (d.read.present) {
      map['read'] = Variable<bool, BoolType>(d.read.value);
    }
    if (d.send.present) {
      map['send'] = Variable<bool, BoolType>(d.send.value);
    }
    return map;
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(_db, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final String id;
  final String de;
  final String idOuter;
  final String photofrom;
  Chat(
      {@required this.id,
      @required this.de,
      @required this.idOuter,
      @required this.photofrom});
  factory Chat.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Chat(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      de: stringType.mapFromDatabaseResponse(data['${effectivePrefix}de']),
      idOuter: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_outer']),
      photofrom: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}photofrom']),
    );
  }
  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Chat(
      id: serializer.fromJson<String>(json['id']),
      de: serializer.fromJson<String>(json['de']),
      idOuter: serializer.fromJson<String>(json['idOuter']),
      photofrom: serializer.fromJson<String>(json['photofrom']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'de': serializer.toJson<String>(de),
      'idOuter': serializer.toJson<String>(idOuter),
      'photofrom': serializer.toJson<String>(photofrom),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Chat>>(bool nullToAbsent) {
    return ChatsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      de: de == null && nullToAbsent ? const Value.absent() : Value(de),
      idOuter: idOuter == null && nullToAbsent
          ? const Value.absent()
          : Value(idOuter),
      photofrom: photofrom == null && nullToAbsent
          ? const Value.absent()
          : Value(photofrom),
    ) as T;
  }

  Chat copyWith({String id, String de, String idOuter, String photofrom}) =>
      Chat(
        id: id ?? this.id,
        de: de ?? this.de,
        idOuter: idOuter ?? this.idOuter,
        photofrom: photofrom ?? this.photofrom,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('de: $de, ')
          ..write('idOuter: $idOuter, ')
          ..write('photofrom: $photofrom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(de.hashCode, $mrjc(idOuter.hashCode, photofrom.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == id &&
          other.de == de &&
          other.idOuter == idOuter &&
          other.photofrom == photofrom);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> id;
  final Value<String> de;
  final Value<String> idOuter;
  final Value<String> photofrom;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.de = const Value.absent(),
    this.idOuter = const Value.absent(),
    this.photofrom = const Value.absent(),
  });
  ChatsCompanion copyWith(
      {Value<String> id,
      Value<String> de,
      Value<String> idOuter,
      Value<String> photofrom}) {
    return ChatsCompanion(
      id: id ?? this.id,
      de: de ?? this.de,
      idOuter: idOuter ?? this.idOuter,
      photofrom: photofrom ?? this.photofrom,
    );
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  final GeneratedDatabase _db;
  final String _alias;
  $ChatsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deMeta = const VerificationMeta('de');
  GeneratedTextColumn _de;
  @override
  GeneratedTextColumn get de => _de ??= _constructDe();
  GeneratedTextColumn _constructDe() {
    return GeneratedTextColumn(
      'de',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idOuterMeta = const VerificationMeta('idOuter');
  GeneratedTextColumn _idOuter;
  @override
  GeneratedTextColumn get idOuter => _idOuter ??= _constructIdOuter();
  GeneratedTextColumn _constructIdOuter() {
    return GeneratedTextColumn(
      'id_outer',
      $tableName,
      false,
    );
  }

  final VerificationMeta _photofromMeta = const VerificationMeta('photofrom');
  GeneratedTextColumn _photofrom;
  @override
  GeneratedTextColumn get photofrom => _photofrom ??= _constructPhotofrom();
  GeneratedTextColumn _constructPhotofrom() {
    return GeneratedTextColumn(
      'photofrom',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, de, idOuter, photofrom];
  @override
  $ChatsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'chats';
  @override
  final String actualTableName = 'chats';
  @override
  VerificationContext validateIntegrity(ChatsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.de.present) {
      context.handle(_deMeta, de.isAcceptableValue(d.de.value, _deMeta));
    } else if (de.isRequired && isInserting) {
      context.missing(_deMeta);
    }
    if (d.idOuter.present) {
      context.handle(_idOuterMeta,
          idOuter.isAcceptableValue(d.idOuter.value, _idOuterMeta));
    } else if (idOuter.isRequired && isInserting) {
      context.missing(_idOuterMeta);
    }
    if (d.photofrom.present) {
      context.handle(_photofromMeta,
          photofrom.isAcceptableValue(d.photofrom.value, _photofromMeta));
    } else if (photofrom.isRequired && isInserting) {
      context.missing(_photofromMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Chat.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ChatsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.de.present) {
      map['de'] = Variable<String, StringType>(d.de.value);
    }
    if (d.idOuter.present) {
      map['id_outer'] = Variable<String, StringType>(d.idOuter.value);
    }
    if (d.photofrom.present) {
      map['photofrom'] = Variable<String, StringType>(d.photofrom.value);
    }
    return map;
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $MessagesTable _messages;
  $MessagesTable get messages => _messages ??= $MessagesTable(this);
  $ChatsTable _chats;
  $ChatsTable get chats => _chats ??= $ChatsTable(this);
  @override
  List<TableInfo> get allTables => [messages, chats];
}
