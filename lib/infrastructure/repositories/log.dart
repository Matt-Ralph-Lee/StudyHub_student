import 'log_level.dart';

class Log {
  const Log({
    required this.createdAt,
    required this.level,
    required this.tags,
    required this.message,
  });

  final String createdAt;
  final LogLevel level;
  final String message;
  final List<String> tags;
}
