Map<String, bool> createTokenMap(final String s) {
  final map = <String, bool>{};
  for (int i = 0; i < s.length - 1; i++) {
    map[s.substring(i, i + 2)] = true;
  }

  return map;
}
