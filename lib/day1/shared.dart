int parseFirstAndLastNumberChars(String line) {
  final chars = line.split('');
  final firstNumberChar = chars.first;
  final lastNumberChar = chars.reversed.first;
  return int.parse(firstNumberChar + lastNumberChar);
}
