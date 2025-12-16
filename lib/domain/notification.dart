class Notification {
  final int id;
  final int userId;
  final String content;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.content,
    required this.isRead,
    required this.createdAt,
  });
  Notification copyWith({
    int? id,
    int? userId,
    String? content,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
