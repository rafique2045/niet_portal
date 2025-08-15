import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:niet_portal/roboto/models/chat_session.dart';
import 'package:niet_portal/roboto/services/database_helper.dart';

class SessionProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<ChatSession> _sessions = [];
  bool _isLoading = false;

  List<ChatSession> get sessions => _sessions;
  bool get isLoading => _isLoading;

  SessionProvider() {
    loadSessions();
  }

  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners();
    _sessions = await _dbHelper.getSessions();
    _isLoading = false;
    notifyListeners();
  }

  Future<int> createNewSession() async {
    final newSession = ChatSession(
      title: 'New Chat - ${DateFormat.yMMMd().add_jm().format(DateTime.now())}',
      createdAt: DateTime.now(),
    );
    final id = await _dbHelper.insertSession(newSession);
    await loadSessions();
    return id;
  }

  Future<void> deleteSession(int id) async {
    await _dbHelper.deleteSession(id);
    await loadSessions();
  }

  Future<void> renameSession(int id, String newTitle) async {
    await _dbHelper.updateSessionTitle(id, newTitle);
    await loadSessions();
  }
}
