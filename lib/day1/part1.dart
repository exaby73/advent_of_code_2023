import 'package:aoc_2023/day1/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(1);
  int sum = 0;
  for (final line in input) {
    final chars = line.split('');
    final firstNumberChar = chars.firstNumberChar;
    final lastNumberChar = chars.reversed.firstNumberChar;
    sum += int.parse(firstNumberChar + lastNumberChar);
  }
  print(sum);
}
