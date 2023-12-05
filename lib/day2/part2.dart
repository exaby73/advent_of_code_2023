import 'package:aoc_2023/day2/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(2);
  int powerSum = 0;
  for (final line in input) {
    final game = createGameFromString(line);
    powerSum += game.minimumColors.power;
  }
  print(powerSum);
}
