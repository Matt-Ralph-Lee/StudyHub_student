import 'package:flutter/foundation.dart';

import '../../application/interfaces/i_logger.dart';
import 'log.dart';
import 'log_level.dart';

class FirebaseLogger implements ILogger {
  final String? consoleFilterTag;
  final LogLevel consoleFilterMinLevel;

  FirebaseLogger({
    this.consoleFilterTag,
    this.consoleFilterMinLevel = LogLevel.debug,
  });

  final _logLevelPrefixes = {
    LogLevel.fatal: 'FATAL',
    LogLevel.error: 'ERROR',
    LogLevel.warn: 'WARN',
    LogLevel.info: 'INFO',
    LogLevel.debug: 'DEBUG',
    LogLevel.trace: 'TRACE',
  };

  void _printToConsoleIfNeeded(final Log log) {
    if (consoleFilterTag != null) {
      final shouldPrint = log.tags.contains(consoleFilterTag);
      if (!shouldPrint) {
        return;
      }
    }
    if (log.level.priority < consoleFilterMinLevel.priority) {
      return;
    }
    final levelPrefix = _logLevelPrefixes[log.level] ?? 'UNKNOWN_LOG_LEVEL:';
    final msg = log.message;
    final text = '[$levelPrefix] $msg';
    debugPrint(text);
  }

  void _onCreateLog(final Log log) {
    _printToConsoleIfNeeded(log);
  }

  @override
  void fatal(final String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.fatal,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }

  @override
  void error(final String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.error,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }

  @override
  void info(final String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.info,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }

  @override
  void debug(final String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.debug,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }

  @override
  void trace(String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.trace,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }

  @override
  void warn(String message) {
    final now = DateTime.now().toIso8601String();
    final log = Log(
      createdAt: now,
      level: LogLevel.warn,
      tags: [],
      message: message,
    );
    _onCreateLog(log);
  }
}
