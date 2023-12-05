import 'dart:io';

final _numberMap = {
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
};

void main() {
  final input = File('inputs/day1.txt').readAsLinesSync();
  int sum = 0;
  for (final line in input) {
    final backwardLine = line.split('').reversed.join();
    int? first = null;
    int? second = null;
    final forwardRegex = RegExp(
      _numberMap.entries.map((e) => '(${e.key}|${e.value})').join('|'),
    );
    final backwardRegex = RegExp(
      _numberMap.entries
          .map((e) => '(${e.key.split('').reversed.join()}|${e.value})')
          .join('|'),
    );
    final firstMatch = forwardRegex.firstMatch(line)!;
    final secondMatch = backwardRegex.firstMatch(backwardLine)!;
    final firstString = line.substring(firstMatch.start, firstMatch.end);
    final secondString = backwardLine
        .substring(secondMatch.start, secondMatch.end)
        .split('')
        .reversed
        .join();
    first = int.tryParse(firstString) ?? _numberMap[firstString];
    second = int.tryParse(secondString) ?? _numberMap[secondString];
    sum += first! * 10 + second!;
  }
  print(sum);
}
