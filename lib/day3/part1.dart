import 'package:aoc_2023/day3/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsMatrix(3);
  final numbers = input.getSurroundingNumbersSymbols();
  print(numbers.sum);
}
