import 'package:aoc_2023/day4/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(4);
  final cards = input.cards;
  print(cards.totalScratchCardsWon);
}
