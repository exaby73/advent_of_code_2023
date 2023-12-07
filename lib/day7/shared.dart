import 'package:aoc_2023/utils.dart';
import 'package:collection/collection.dart';

typedef Rank = int;

typedef Hand = List<Rank>;

typedef HandWithStrengthAndBid = ({Hand hand, int bid, bool joker});

extension ParseHand on InputList {
  List<HandWithStrengthAndBid> parsedHands({required bool joker}) {
    return map((e) {
      final [rawHand, rawBid] = e.split(' ').toList();
      final ranks =
          rawHand.split('').map((e) => _cardToRank(e, joker: joker)).toList();
      final bid = int.parse(rawBid);

      return (
        hand: ranks,
        bid: bid,
        joker: joker,
      );
    }).toList();
  }

  int _cardToRank(String card, {required bool joker}) {
    final rank = int.tryParse(card);
    if (rank != null) {
      return rank;
    }
    return switch (card) {
      'A' => 14,
      'K' => 13,
      'Q' => 12,
      'J' => joker ? 1 : 11,
      'T' => 10,
      _ => throw StateError('Invalid card: $card'),
    };
  }
}

enum HandType {
  fiveOfAKind(7),
  fourOfAKind(6),
  fullHouse(5),
  threeOfAKind(4),
  twoPair(3),
  onePair(2),
  highCard(1);

  final int power;

  const HandType(this.power);
}

extension Strength on Hand {
  HandType type({required bool joker}) {
    final Map<int, int> map = {};
    forEach((hand) {
      map.update(hand, (rank) => rank + 1, ifAbsent: () => 1);
    });
    final hasJoker = joker && map[1] != null;
    if (hasJoker) {
      final numberOfJokers = map[1]!;
      final highestEntry = map.entries.fold(
        MapEntry(-1, -1),
        (entry, e) {
          if (e.key == 1) return entry;
          return entry.value > e.value ? entry : e;
        },
      );
      if (highestEntry.key != 1) {
        map[highestEntry.key] = highestEntry.value + numberOfJokers;
        map.remove(1);
      }
    }
    
    if (map.keys.length == 1) return HandType.fiveOfAKind;
    if (map.keys.length == 2) {
      if (map.values.any((numberOfCards) => numberOfCards == 4)) {
        return HandType.fourOfAKind;
      }
      return HandType.fullHouse;
    }
    if (map.keys.length == 3) {
      if (map.values.any((numberOfCards) => numberOfCards == 3)) {
        return HandType.threeOfAKind;
      }
      return HandType.twoPair;
    }
    if (map.keys.length == 4) return HandType.onePair;
    return HandType.highCard;
  }

  int compareTo(Hand other, {required bool joker}) {
    final selfType = type(joker: joker);
    final otherType = other.type(joker: joker);
    if (selfType != otherType) {
      return selfType.power - otherType.power;
    }
    late int result;
    forEachIndexedWhile(
      (index, rank) {
        final otherRank = other[index];
        if (rank == otherRank) return true;
        result = rank - otherRank;
        return false;
      },
    );
    return result;
  }
}

extension CalculateWinnings on List<HandWithStrengthAndBid> {
  int get winnings {
    sort(
      (a, b) => a.hand.compareTo(
        b.hand,
        joker: assertAndReturn(a.joker == b.joker, a.joker),
      ),
    );
    return indexed.fold(0, (sum, e) => sum + e.$2.bid * (e.$1 + 1));
  }
}
