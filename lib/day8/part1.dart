import 'package:aoc_2023/day8/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(8);
  print(input.nodesWithDirections.steps(start: 'AAA', end: 'ZZZ'));
}
