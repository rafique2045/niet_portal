import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/chat_message.dart';
import '../models/chat_session.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'chat_app.db');

    return openDatabase(
      path,
      version: 2, // Incremented version
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      sessionId INTEGER,
      text TEXT,
      sender TEXT,
      timestamp TEXT,
      imagePath TEXT, 
      FOREIGN KEY(sessionId) REFERENCES sessions(id) ON DELETE CASCADE
      )
    ''');
  }

  // Handle database schema upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE messages ADD COLUMN imagePath TEXT');
    }
  }

  // Session CRUD
  Future<int> insertSession(ChatSession session) async {
    final db = await database;
    return await db.insert('sessions', session.toMap());
  }

  Future<List<ChatSession>> getSessions() async {
    final db = await database;
    final maps = await db.query('sessions', orderBy: 'createdAt DESC');
    return maps.map((m) => ChatSession.fromMap(m)).toList();
  }

  Future<int> deleteSession(int id) async {
    final db = await database;
    return await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateSessionTitle(int id, String newTitle) async {
    final db = await database;
    return await db.update(
      'sessions',
      {'title': newTitle},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Message CRUD
  Future<int> insertMessage(ChatMessage msg) async {
    final db = await database;
    return await db.insert('messages', msg.toMap());
  }

  Future<List<ChatMessage>> getMessages(int sessionId) async {
    final db = await database;
    final maps = await db.query(
      'messages',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
      orderBy: 'timestamp ASC',
    );
    return maps.map((m) => ChatMessage.fromMap(m)).toList();
  }
}
