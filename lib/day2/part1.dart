import 'package:aoc_2023/day2/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  const Config config = (red: 12, green: 13, blue: 14);
  final input = readInputAsLines(2);
  int idSum = 0;
  for (final line in input) {
    final game = createGameFromString(line);
    if (game.isValid(config)) {
      idSum += game.id;
    }
  }
  print(idSum);
}
