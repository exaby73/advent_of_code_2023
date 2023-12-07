import 'package:aoc_2023/day7/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(7);
  print(input.parsedHands(joker: true).winnings);
}
