import 'dart:io';

import 'package:aoc_2023/utils.dart';

void main() {
  final input = readInputAsLines(1);
  int sum = 0;
  for (final line in input) {
    final chars = line.split('');
    int? firstNumber;
    int? lastNumber;
    for (final char in chars) {
      final number = int.tryParse(char);
      if (number != null) {
        if (firstNumber == null) {
          firstNumber = number;
        }
        lastNumber = number;
      }
    }
    sum += (firstNumber! * 10) + (lastNumber ?? firstNumber);
  }
  print(sum);
}
