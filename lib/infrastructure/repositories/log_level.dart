enum LogLevel {
  fatal(60),
  error(50),
  warn(40),
  info(30),
  debug(20),
  trace(10);

  const LogLevel(this.priority);
  final int priority;
}
