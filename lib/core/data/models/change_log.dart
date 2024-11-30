class ChangeLog {
  final int id;
  final String userId;
  final String operation; // 'create', 'update', 'delete'
  final DateTime timestamp;

  ChangeLog({
    required this.id,
    required this.userId,
    required this.operation,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'operation': operation,
    'timestamp': timestamp.toIso8601String(),
  };

  static ChangeLog fromMap(Map<String, dynamic> map) => ChangeLog(
    id: map['id'],
    userId: map['userId'],
    operation: map['operation'],
    timestamp: DateTime.parse(map['timestamp']),
  );
}
