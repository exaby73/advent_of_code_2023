extension FirstChar on Iterable<String> {
  String get firstNumberChar {
    for (final char in this) {
      if (int.tryParse(char) != null) return char;
    }
    throw StateError('No number found in $this');
  }
}
