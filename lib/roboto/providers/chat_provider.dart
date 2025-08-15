import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';
import 'package:niet_portal/roboto/constants.dart';
import 'package:niet_portal/roboto/models/chat_message.dart';
import 'package:niet_portal/roboto/services/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChatProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late GenerativeModel _model;

  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final int sessionId;
  String? _error;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ChatProvider(this.sessionId) {
    _initializeGemini();
    loadMessages();
  }

  void _initializeGemini() {
    _error = null;
    if (GEMINI_API_KEY.isEmpty || GEMINI_API_KEY == 'YOUR_GEMINI_API_KEY') {
      _error = 'API Key Error: Please set your API key in lib/constants.dart';
      notifyListeners();
      return;
    }
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: GEMINI_API_KEY);
  }

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();
    _messages = (await _dbHelper.getMessages(sessionId)).reversed.toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage({String? text, File? imageFile}) async {
    if ((text == null || text.trim().isEmpty) && imageFile == null) {
      return;
    }
    _error = null;

    String? imagePath;
    if (imageFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      imagePath = savedImage.path;
    }

    final userMessage = ChatMessage(
      text: text ?? '',
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      imageFile: imageFile,
      imagePath: imagePath,
      sessionId: sessionId,
    );

    _messages.insert(0, userMessage);
    _isLoading = true;
    notifyListeners();

    await _dbHelper.insertMessage(userMessage);

    try {
      final List<Part> contentParts = [];

      if (imageFile != null) {
        final imageBytes = await imageFile.readAsBytes();
        final mimeType = lookupMimeType(imageFile.path);
        if (mimeType != null && mimeType.startsWith('image/')) {
          contentParts.add(DataPart(mimeType, imageBytes));
        } else {
          _error = 'Unsupported file type for image.';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      if (text != null && text.trim().isNotEmpty) {
        contentParts.add(TextPart(text));
      }

      final responses =
          _model.generateContentStream([Content.multi(contentParts)]);

      final geminiMessage = ChatMessage(
        text: '',
        timestamp: DateTime.now(),
        sender: MessageSender.gemini,
        sessionId: sessionId,
        isLoading: true,
      );
      _messages.insert(0, geminiMessage);
      _isLoading = false;
      notifyListeners();

      StringBuffer buffer = StringBuffer();
      await for (var response in responses) {
        final newText = response.text ?? '';
        buffer.write(newText);
        _messages[0] = _messages.first.copyWith(
          text: buffer.toString(),
        );
        notifyListeners();
      }

      final finalGeminiMessage = _messages.first.copyWith(isLoading: false);
      _messages[0] = finalGeminiMessage;
      await _dbHelper.insertMessage(finalGeminiMessage);
    } catch (e) {
      print('Error sending message: $e');
      _error = 'Failed to get response: ${e.toString()}';
      if (_messages.isNotEmpty &&
          _messages.first.sender == MessageSender.gemini) {
        _messages.removeAt(0);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
