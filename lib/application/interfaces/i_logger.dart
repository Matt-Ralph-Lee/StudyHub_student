abstract class ILogger {
  void fatal(final String message);
  void error(final String message);
  void warn(final String message);
  void info(final String message);
  void debug(final String message);
  void trace(final String message);
}
