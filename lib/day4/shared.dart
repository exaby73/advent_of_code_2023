import 'package:aoc_2023/utils.dart';

typedef Card = ({
  int id,
  List<int> winningNumbers,
  List<int> numbers,
});

extension InputListX on InputList {
  List<Card> get cards {
    final List<Card> cards = [];
    for (var line in this) {
      line = line.replaceFirst(RegExp(r'Card\s+'), '');
      final [left, right] = line.split(':');
      final id = int.parse(left.trim());
      final [winningString, numbersString] = right.trim().split('|');
      final winning = winningString
          .split(RegExp(r'\s+'))
          .where((element) => element.isNotEmpty)
          .map(int.parse)
          .toList();
      final numbers = numbersString
          .split(RegExp(r'\s+'))
          .where((element) => element.isNotEmpty)
          .map(int.parse)
          .toList();
      cards.add((id: id, winningNumbers: winning, numbers: numbers));
    }
    return cards;
  }
}

extension CardX on Card {
  int get points {
    int points = 0;
    for (final winningNumber in winningNumbers) {
      if (numbers.contains(winningNumber)) {
        points = points == 0 ? 1 : points * 2;
      }
    }
    return points;
  }

  int get numberOfWonNumbers => winningNumbers.fold(
        0,
        (sum, e) => numbers.contains(e) ? sum + 1 : sum,
      );
}

extension CardsX on List<Card> {
  int get totalPoints => fold(0, (sum, e) => sum + e.points);

  int get totalScratchCardsWon {
    final totalCards = Map.fromEntries(map((e) => MapEntry(e.id, 1)));
    for (int i = 0; i < length; i++) {
      final card = this[i];
      final numberOfWonNumbers = card.numberOfWonNumbers * totalCards[card.id]!;
      for (int j = 0; j < numberOfWonNumbers; j++) {
        totalCards.update(
          card.id + (j ~/ totalCards[card.id]!) + 1,
          (value) => value + 1,
        );
      }
    }
    return totalCards.entries.fold(0, (sum, e) => sum + e.value);
  }
}
