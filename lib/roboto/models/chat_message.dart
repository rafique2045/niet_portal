import 'dart:io';

enum MessageSender { user, gemini }

class ChatMessage {
  final int? id;
  final int sessionId;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final File? imageFile; // For displaying images in the UI
  final String? imagePath; // For database persistence
  final bool isLoading;

  ChatMessage({
    this.id,
    required this.sessionId,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.imageFile,
    this.imagePath,
    this.isLoading = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'text': text,
      'sender': sender.name,
      'timestamp': timestamp.toIso8601String(),
      'imagePath': imagePath,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    final imagePath = map['imagePath'] as String?;
    final file = (imagePath != null && File(imagePath).existsSync())
        ? File(imagePath)
        : null;

    return ChatMessage(
      id: map['id'],
      sessionId: map['sessionId'],
      text: map['text'],
      sender: MessageSender.values.firstWhere(
        (e) => e.name == map['sender'],
        orElse: () => MessageSender.gemini,
      ),
      timestamp: DateTime.parse(map['timestamp']),
      imagePath: imagePath,
      imageFile: file,
    );
  }

  ChatMessage copyWith({
    int? id,
    int? sessionId,
    String? text,
    MessageSender? sender,
    DateTime? timestamp,
    File? imageFile,
    String? imagePath,
    bool? isLoading,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      imageFile: imageFile ?? this.imageFile,
      imagePath: imagePath ?? this.imagePath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
