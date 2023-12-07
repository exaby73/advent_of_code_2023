import 'package:aoc_2023/day5/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsString(5);
  final inputSet = input.inputSet();
  print(inputSet.lowestOf('seed', 'location'));
}
