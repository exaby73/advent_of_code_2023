import 'package:aoc_2023/utils.dart';

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
  final inputLines = readInputAsLines(1);
  int totalSum = 0;

  for (final line in inputLines) {
    totalSum += calculateSumOfParsedLineNumbers(line);
  }

  print(totalSum);
}

int calculateSumOfParsedLineNumbers(String line) {
  final reversedLine = line.split('').reversed.join();

  int firstNumber = parseNumberFromLine(line, false);
  int secondNumber = parseNumberFromLine(reversedLine, true);

  return firstNumber * 10 + secondNumber;
}

int parseNumberFromLine(String line, bool isReversed) {
  final String numberPattern = _getRegexPattern(isReversed);
  final numberRegex = RegExp(numberPattern);
  final match = numberRegex.firstMatch(line)!;
  final matchStart = match.start;
  final matchEnd = match.end;
  var numberString = line.substring(matchStart, matchEnd);
  if (isReversed && numberPattern.length > 1) {
    numberString = numberString.split('').reversed.join();
  }
  return int.tryParse(numberString) ?? _numberMap[numberString]!;
}

String _getRegexPattern(bool isReversed) {
  late String pattern;
  if (isReversed) {
    pattern = _numberMap.entries
        .map((e) => '(${e.key.split('').reversed.join()}|${e.value})')
        .join('|');
  } else {
    pattern = _numberMap.entries.map((e) => '(${e.key}|${e.value})').join('|');
  }
  return pattern;
}
