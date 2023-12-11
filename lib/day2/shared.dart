import 'dart:math';

import 'package:string_scanner/string_scanner.dart';

typedef Round = ({
  int red,
  int green,
  int blue,
});

typedef Game = ({
  int id,
  List<Round> rounds,
});

typedef Config = Round;

extension GameX on Game {
  bool isValid(Config config) {
    for (final round in rounds) {
      if (round.red > config.red ||
          round.blue > config.blue ||
          round.green > config.green) {
        return false;
      }
    }
    return true;
  }

  Round get minimumColors {
    return rounds.fold(
      (red: 0, green: 0, blue: 0),
      (minimum, round) => (
        red: max(minimum.red, round.red),
        green: max(minimum.green, round.green),
        blue: max(minimum.blue, round.blue),
      ),
    );
  }
}

extension RoundX on Round {
  Round copyWith({int? red, int? green, int? blue}) {
    return (
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
    );
  }

  int get power => red * green * blue;
}

Game createGameFromString(String input) {
  final scanner = StringScanner(input);
  scanner.expect('Game ');
  scanner.expect(RegExp(r'(\d+)'));
  final id = int.parse(scanner.lastMatch!.group(0)!);
  scanner.scan(': ');
  final game = scanner.rest.split('; ');
  final rounds = <Round>[];
  for (final hand in game) {
    final cubes = hand.split(', ');
    Round round = (red: 0, green: 0, blue: 0);
    for (final color in cubes) {
      final scanner = StringScanner(color);

      scanner.expect(RegExp(r'(\d+)'));
      final number = int.parse(scanner.lastMatch!.group(0)!);

      scanner.expect(' ');
      scanner.expect(RegExp(r'(\w+)'));
      final colorString = scanner.lastMatch!.group(0)!;

      round = switch (colorString) {
        'red' => round.copyWith(red: number),
        'green' => round.copyWith(green: number),
        'blue' => round.copyWith(blue: number),
        _ => throw StateError('Unexpected color: $colorString'),
      };
    }
    rounds.add(round);
  }
  return (id: id, rounds: rounds);
}
