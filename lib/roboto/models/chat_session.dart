class ChatSession {
  final int? id;
  final String title;
  final DateTime createdAt;

  ChatSession({this.id, required this.title, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChatSession.fromMap(Map<String, dynamic> map) {
    return ChatSession(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
